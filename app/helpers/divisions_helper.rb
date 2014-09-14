module DivisionsHelper
  def division_date_and_time(division)
    text = formatted_date(division.date)
    text += " at " + division.clock_time if division.clock_time
    text
  end

  def member_division_path2(member, division)
    member_division_path(division_params(division).merge(member_params(member)))
  end

  def division_with_policy_path(division, q = {})
    dmp = (q[:dmp] || current_user.nil?) ? q[:dmp] : current_user.active_policy_id
    division_path2(division, q.merge(dmp: dmp))
  end

  def division_path2(division, q = {})
    division_path(q.merge(division_params(division)))
  end

  def division_params(division)
    {
      date: division.date,
      number: division.number,
      house: division.australian_house
    }
  end

  def history_division_path2(division)
    history_division_path(division_params(division))
  end

  def aye_vote_class(whip)
    if whip.aye_votes == 0
      "normal"
    # Special case for free votes
    elsif whip.whip_guess == "aye" || whip.free?
      "whip"
    else
      "rebel"
    end
  end

  def no_vote_class(whip)
    if whip.no_votes == 0
      "normal"
    # Special case for free votes
    elsif whip.whip_guess == "no" || whip.free?
      "whip"
    else
      "rebel"
    end
  end

  def no_vote_total_class(division)
    division.no_votes >= division.aye_votes ? "whip" : "normal"
  end

  def aye_vote_total_class(division)
    division.aye_votes >= division.no_votes ? "whip" : "normal"
  end

  def vote_display_in_table(vote)
    case vote
    when "aye3"
      "Aye (strong)"
    when "no3"
      "No (strong)"
    when "absent"
      "absent"
    else
      vote.capitalize
    end
  end

  # TODO: Refactor this - it looks suspiciously like the above
  def simple_vote_display(vote)
    vote == 'aye3' || vote == 'no3' ? "#{vote[0...-1]} (strong)" : vote
  end

  def division_outcome(division)
    division.passed? ? 'Passed' : 'Not passed'
  end

  def division_outcome_with_score(division)
    result = division_outcome(division) + " "
    result += content_tag(:span, :class => "division-outcome-score") do
      if division.passed?
        text = division.aye_votes_including_tells.to_s + " – " + division.no_votes_including_tells.to_s
      else
        text = division.no_votes_including_tells.to_s + " – " + division.aye_votes_including_tells.to_s
      end
    end
    result.html_safe
  end

  def member_voted_with(member, division)
    # We're using a different member for the link to try to make things the same as the php
    # TODO get rid of this silliness as soon as we can
    member2 = Member.where(person_id: member.person_id, house: division.house).current_on(division.date).first
    sentence = link_to member2.full_name, member_path2(member2)
    sentence += " "
    if member.vote_on_division_without_tell(division) == "absent"
      sentence += "did not vote."
    end

    if !division.action_text.empty? && division.action_text[member.vote_on_division_without_tell(division)]
      sentence += "voted ".html_safe + content_tag(:em, division.action_text[member.vote_on_division_without_tell(division)])
    else
      # TODO Should be using whip for this calculation. Only doing it this way to match php
      # calculation
      ayenodiff = (division.votes.group(:vote).count["aye"] || 0) - (division.votes.group(:vote).count["no"] || 0)
      if ayenodiff == 0
        if member.vote_on_division_without_tell(division) != "absent"
          sentence += "voted #{member.vote_on_division_without_tell(division).capitalize}."
        end
      elsif member.vote_on_division_without_tell(division) == "aye" && ayenodiff >= 0 || member.vote_on_division_without_tell(division) == "no" && ayenodiff < 0
        sentence += "voted ".html_safe + content_tag(:em, "with the majority")
      elsif member.vote_on_division_without_tell(division) != "absent"
        sentence += "voted ".html_safe + content_tag(:em, "in the minority")
      end

      if member.vote_on_division_without_tell(division) != "absent" && ayenodiff != 0
        sentence += " (#{member.vote_on_division_without_tell(division).capitalize})."
      end
      sentence
    end
  end

  def relative_time(time)
    time < 1.month.ago ? formatted_date(time) : "#{time_ago_in_words(time)} ago"
  end
end
