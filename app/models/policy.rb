class Policy < ActiveRecord::Base
  searchkick if Settings.elasticsearch
  # Using proc form of meta so that policy_id is set on create as well
  # See https://github.com/airblade/paper_trail/issues/185#issuecomment-11781496 for more details
  has_paper_trail meta: { policy_id: Proc.new{|policy| policy.id} }
  has_many :policy_divisions
  has_many :divisions, through: :policy_divisions
  has_many :policy_person_distances, dependent: :destroy
  has_many :divisions, through: :policy_divisions
  has_many :watches, as: :watchable
  belongs_to :user

  validates :name, :description, :user_id, :private, presence: true
  validates :name, uniqueness: true, length: { maximum: 100 }

  enum private: [:published, 'legacy Dream MP', :provisional]
  alias_attribute :status, :private

  def name_with_for
    "for #{name}"
  end

  def vote_for_division(division)
    policy_division = division.policy_divisions.find_by(policy: self)
    policy_division.vote if policy_division
  end

  def unedited_motions_count
    divisions.unedited.count
  end

  def most_recent_version
    PaperTrail::Version.order(created_at: :desc).find_by(policy_id: id)
  end

  def last_edited_at
    most_recent_version ? most_recent_version.created_at : updated_at
  end

  def last_edited_by
    User.find(most_recent_version.whodunnit)
  end

  def self.find_by_search_query(query)
    if Settings.elasticsearch
      self.search(query)
    else
      where('LOWER(convert(name using utf8)) LIKE :query
             OR LOWER(convert(description using utf8)) LIKE :query', query: "%#{query}%")
    end
  end

  def self.update_all!
    all.each { |p| p.calculate_member_distances! }
  end

  def calculate_member_distances!
    policy_person_distances.delete_all

    policy_divisions.each do |policy_division|
      Member.current_on(policy_division.date).where(house: policy_division.house).each do |member|
        member_vote = member.vote_on_division_without_tell(policy_division.division)

        attribute = if policy_division.strong_vote?
          if member_vote == 'absent'
            :nvotesabsentstrong
          elsif member_vote == PolicyDivision.vote_without_strong(policy_division.vote)
            :nvotessamestrong
          else
            :nvotesdifferstrong
          end
        else
          if member_vote == 'absent'
            :nvotesabsent
          elsif member_vote == PolicyDivision.vote_without_strong(policy_division.vote)
            :nvotessame
          else
            :nvotesdiffer
          end
        end

        PolicyPersonDistance.find_or_create_by(person_id: member.person_id, policy_id: id).increment!(attribute)
      end
    end

    policy_person_distances.reload.each do |pmd|
      pmd.update!({
        distance_a: Distance.distance_a(pmd.nvotessame, pmd.nvotesdiffer, pmd.nvotesabsent,
          pmd.nvotessamestrong, pmd.nvotesdifferstrong, pmd.nvotesabsentstrong),
        distance_b: Distance.distance_b(pmd.nvotessame, pmd.nvotesdiffer,
          pmd.nvotessamestrong, pmd.nvotesdifferstrong)
      })
    end
  end

  def current_members_very_strongly_for
    current_members(policy_person_distances.very_strongly_for)
  end

  def current_members_strongly_for
    current_members(policy_person_distances.strongly_for)
  end

  def current_members_moderately_for
    current_members(policy_person_distances.moderately_for)
  end

  def current_members_for_and_against
    current_members(policy_person_distances.for_and_against)
  end

  def current_members_moderately_against
    current_members(policy_person_distances.moderately_against)
  end

  def current_members_strongly_against
    current_members(policy_person_distances.strongly_against)
  end

  def current_members_very_strongly_against
    current_members(policy_person_distances.very_strongly_against)
  end

  def current_members_never_voted
    current_members(policy_person_distances.never_voted)
  end

  def current_members_vote_counts
    very_strongly_for_count = current_members_very_strongly_for.count || 0
    strongly_for_count = current_members_strongly_for.count || 0
    moderately_for_count = current_members_moderately_for.count || 0
    for_count = very_strongly_for_count + strongly_for_count + moderately_for_count

    very_strongly_against_count = current_members_very_strongly_against.count || 0
    strongly_against_count = current_members_strongly_against.count || 0
    moderately_against_count = current_members_moderately_against.count || 0
    against_count = very_strongly_against_count + strongly_against_count + moderately_against_count

    for_and_against_count = current_members_for_and_against.count || 0
    never_count = current_members_never_voted.count || 0

    # total count must be at least 1 to prevent div by 0 errors
    total_count = [1, for_count + against_count + for_and_against_count + never_count].max

    for_percent = (for_count.to_f / total_count.to_f) * 100
    against_percent = (against_count.to_f / total_count.to_f) * 100
    for_and_against_percent = (for_and_against_count.to_f / total_count.to_f) * 100
    never_percent = (never_count.to_f / total_count.to_f) * 100

    {
      "very_strongly_for_count" => very_strongly_for_count,
      "strongly_for_count" => strongly_for_count,
      "moderately_for_count" => moderately_for_count,
      "for_count" => for_count,
      "for_percent" => for_percent,
      "very_strongly_against_count" => very_strongly_against_count,
      "strongly_against_count" => strongly_against_count,
      "moderately_against_count" => moderately_against_count,
      "against_count" => against_count,
      "against_percent" => against_percent,
      "for_and_against_count" => for_and_against_count,
      "for_and_against_percent" => for_and_against_percent,
      "never_count" => never_count,
      "never_percent" => never_percent,
      "total_count" => total_count,
    }
  end

  def alert_watches(version)
    watches.each do |watch|
      AlertMailer.policy_updated(self, version, watch.user).deliver
    end
  end

  handle_asynchronously :alert_watches

  private

  def current_members(policy_person_distances)
    members = policy_person_distances.map { |ppd| ppd.person.member_for_policy(self) }
    members.select { |m| m.currently_in_parliament? }
  end
end
