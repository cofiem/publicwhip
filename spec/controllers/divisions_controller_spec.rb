# frozen_string_literal: true

require "spec_helper"

describe DivisionsController, type: :controller do
  describe "#index" do
    let!(:december_2016_division) { create(:division, date: Date.new(2016, 12, 25)) }
    let!(:june_2016_division) { create(:division, date: Date.new(2016, 0o6, 0o1)) }

    context "when there are no parameters" do
      it "renders the index template with divisions of the same year as the last one stored" do
        get :index

        expect(response).to render_template "divisions/index"
        expect(response).to have_http_status :ok
        expect(assigns(:divisions)).to eq([december_2016_division, june_2016_division])
      end
    end

    context "when request has an invalid date as a parameter" do
      it "returns the generic 404 page" do
        get :index, params: { date: "2017-13-22", house: "representatives" }

        expect(response).to render_template "home/error404"
        expect(response).to have_http_status :not_found
      end
    end

    context "when request has an date parameter with an incorrect format" do
      it "returns the generic 404 page" do
        get :index, params: { date: "2017-12-222", house: "representatives" }

        expect(response).to render_template "home/error404"
        expect(response).to have_http_status :not_found
      end
    end

    context "when the date parameter is a full date" do
      context "when date matches divisions already stored" do
        it "renders the index template with selected divisions" do
          get :index, params: { date: "2016-06-01", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to eq([june_2016_division])
        end
      end

      context "when date does not match any divisions" do
        it "renders the index template with empty divisions" do
          get :index, params: { date: "2017-02-02", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to be_empty
        end
      end
    end

    context "when the date parameter is just a year" do
      context "when date matches divisions already stored" do
        it "renders the index template with selected divisions" do
          get :index, params: { date: "2016", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to eq([december_2016_division, june_2016_division])
        end
      end

      context "when date does not match any divisions" do
        it "renders the index template with empty divisions" do
          get :index, params: { date: "2017", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to be_empty
        end
      end
    end

    context "when the date parameter is just a year and a month (YYYY-MM)" do
      context "when date matches divisions already stored" do
        it "renders the index template with selected divisions" do
          get :index, params: { date: "2016-12", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to eq([december_2016_division])
        end
      end

      context "when date does not match any divisions" do
        it "renders the index template with empty divisions" do
          get :index, params: { date: "2016-05", house: "representatives" }

          expect(response).to render_template "divisions/index"
          expect(response).to have_http_status :ok
          expect(assigns(:divisions)).to be_empty
        end
      end
    end
  end

  describe "#index_with_member" do
    let!(:december_2016_division) { create(:division, date: Date.new(2016, 12, 25)) }
    let!(:june_2016_division) { create(:division, date: Date.new(2016, 0o6, 0o1)) }
    let!(:older_division) { create(:division, date: Date.new(2013, 0o4, 29)) }

    let!(:representative) do
      # Returns the most recent member for this particular fictional person
      person = create(:person)
      create(:member, person: person, house: "representatives", constituency: "Oldtown", first_name: "Jane", last_name: "Lo", entered_house: Date.new(2005, 8, 21), left_house: Date.new(2010, 5, 18))
      create(:member, person: person, house: "representatives", constituency: "Newtown", first_name: "Jane", last_name: "Lo", entered_house: Date.new(2010, 5, 18), left_house: Date.new(9999, 12, 31))
    end

    context "when no date is specified" do
      it "gets votes based on last year on divisions table" do
        get :index_with_member, params: { mpc: "newtown", mpn: "jane_lo", house: "representatives" }

        expect(response).to render_template "divisions/index_with_member"
        expect(response).to have_http_status :ok
        expect(assigns(:member)).to eq(representative)
        expect(assigns(:date_start)).to eq(Date.new(2016, 0o1, 0o1))
        expect(assigns(:date_end)).to eq(Date.new(2017, 0o1, 0o1))
        expect(assigns(:date_range)).to eq(:year)
        expect(assigns(:divisions)).to eq([december_2016_division, june_2016_division])
      end

      it "redirects to canonical url when old member is referenced" do
        get :index_with_member, params: { mpc: "oldtown", mpn: "jane_lo", house: "representatives" }

        expect(response).to redirect_to("/people/representatives/newtown/jane_lo/divisions")
      end
    end

    context "when a date is specified" do
      context "when date is valid" do
        it "gets votes based on the date specified" do
          get :index_with_member, params: { mpc: "newtown", mpn: "jane_lo", house: "representatives", date: "2013" }

          expect(response).to render_template "divisions/index_with_member"
          expect(response).to have_http_status :ok
          expect(assigns(:member)).to eq(representative)
          expect(assigns(:date_start)).to eq(Date.new(2013, 0o1, 0o1))
          expect(assigns(:date_end)).to eq(Date.new(2014, 0o1, 0o1))
          expect(assigns(:date_range)).to eq(:year)
          expect(assigns(:divisions)).to eq([older_division])
        end

        it "redirects to canonical url when old member is referenced" do
          get :index_with_member, params: { mpc: "oldtown", mpn: "jane_lo", house: "representatives", date: "2013" }

          expect(response).to redirect_to("/people/representatives/newtown/jane_lo/divisions/2013")
        end
      end

      context "when date is not valid" do
        it "returns the generic 404 page" do
          get :index_with_member, params: { mpc: "newtown", mpn: "christine_milne", house: "representatives", date: "2013-15-15" }

          expect(response).to render_template "home/error404"
          expect(response).to have_http_status :not_found
        end
      end
    end
  end

  describe "#show" do
    let!(:one_division) do
      division = create(:division, date: Date.new(2017, 4, 6), house: "representatives", number: 100)
      division.update!(
        division_info: create(:division_info, division: division, rebellions: 3),
        whips: [create(:whip, division: division)],
        votes: [create(:vote, division: division)]
      )
      division
    end

    context "when request a specific division" do
      context "when parameters match a division" do
        it "loads it" do
          get :show, params: { house: "representatives", date: "2017-04-06", number: 100 }

          expect(response).to render_template "divisions/show"
          expect(response).to have_http_status :ok
          expect(assigns(:division)).to eq(one_division)
          expect(assigns(:whips)).to eq(one_division.whips)
          expect(assigns(:votes)).to eq(one_division.votes)
          expect(assigns(:rebellions)).to eq(one_division.votes.rebellious)
          expect(assigns(:members)).to eq([one_division.votes.first.member])
          expect(assigns(:members_vote_null)).to eq([])
        end
      end

      context "when parameters do not match a division" do
        it "displays a 404 page" do
          get :show, params: { house: "representatives", date: "2017-04-06", number: 101 }

          expect(response).to render_template "home/error404"
          expect(response).to have_http_status :not_found
        end
      end
    end
  end
end
