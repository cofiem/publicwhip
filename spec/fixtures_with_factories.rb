# frozen_string_literal: true

# Everything is a temporary workaround as a step towards moving away from using fixtures to just using factory bot.
# Here's we're basically recreating the entire fixtures set in one big lump

RSpec.shared_context "with fixtures" do
  let(:division_representatives_2013_03_14_1) do
    division = create(
      :division,
      id: 1,
      date: "2013-3-14",
      clock_time: "010:56:00",
      number: 1,
      house: "representatives",
      name: "Bills &#8212; National Disability Insurance Scheme Bill 2012; Consideration in Detail",
      motion: '<p class="speaker">Jenny Macklin</p><p>I present a supplementary explanatory memorandum to the bill and ask leave of the House to move government amendments (1) to (77), as circulated, together.</p>',
      debate_gid: "uk.org.publicwhip/debate/2013-03-14.17.1"
    )
    create(
      :division_info,
      division_id: division.id,
      turnout: 136,
      possible_turnout: 150,
      aye_majority: -1
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Labor Party",
      no_votes: 1,
      possible_votes: 1,
      whip_guess: "no"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Liberal Party",
      possible_votes: 1,
      whip_guess: "unknown"
    )
    text_body = <<~TEXT
      --- DIVISION TITLE ---

      test

      --- MOTION EFFECT ---

      This is some test text.

      It might relate to bills containing HTML characters like the Carbon Pollution Reduction Scheme Bill&#160;2009 and Bills &#8212; National Disability Insurance Scheme Bill
      --- COMMENTS AND NOTES ---

      (put thoughts and notes for other researchers here)
    TEXT
    create(
      :wiki_motion,
      id: 1,
      division_id: division.id,
      text_body: text_body,
      user_id: user.id,
      created_at: "2013-10-20 00:12:13"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_kevin_rudd.id,
      vote: "no"
    )
    division
  end

  let(:division_senate_2013_03_14_1) do
    division = create(
      :division,
      id: 9,
      date: "2013-3-14",
      number: 1,
      house: "senate",
      name: "Motions &#8212; Renewable Energy Certificates",
      motion: "",
      debate_gid: "uk.org.publicwhip/lords/2013-03-14.22.1"
    )
    create(
      :division_info,
      division_id: division.id,
      turnout: 69,
      possible_turnout: 88,
      aye_majority: -3
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Greens",
      no_votes: 1,
      possible_votes: 1,
      whip_guess: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christine_milne.id,
      vote: "no"
    )
    division
  end

  let(:division_representatives_2006_12_06_3) do
    division = create(
      :division,
      id: 347,
      date: "2006-12-06",
      clock_time: "019:29:00",
      number: 3,
      house: "representatives",
      name: "Prohibition of Human Cloning for Reproduction and the Regulation of Human Embryo Research Amendment Bill 2006 &#8212; Consideration in Detail",
      motion: '<p pwmotiontext="moved">That the amendments (<b>Mr Michael Ferguson&#8217;s</b>) be agreed to.</p>',
      debate_gid: "uk.org.publicwhip/debate/2006-12-06.98.1"
    )
    create(
      :division_info,
      division_id: division.id,
      tells: 4,
      turnout: 129,
      possible_turnout: 150,
      aye_majority: -23
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Labor Party",
      aye_votes: 6,
      aye_tells: 1,
      no_votes: 40,
      no_tells: 1,
      possible_votes: 59,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Country Liberal Party",
      possible_votes: 1,
      whip_guess: "unknown"
    )
    create(
      :whip,
      division_id: division.id,
      party: "CWM",
      possible_votes: 1,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Independent",
      aye_votes: 3,
      possible_votes: 4,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Liberal Party",
      aye_votes: 33,
      no_votes: 33,
      no_tells: 1,
      possible_votes: 73,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "National Party",
      aye_votes: 9,
      aye_tells: 1,
      no_votes: 1,
      possible_votes: 11,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "SPK",
      possible_votes: 1,
      whip_guess: "unknown"
    )
    text_body = <<~TEXT
      --- DIVISION TITLE ---

      Prohibition of Human Cloning for Reproduction and the Regulation of Human Embryo Research Amendment Bill 2006 - Consideration in Detail

      --- MOTION EFFECT ---

      This is some test text. I'd like to illustrate formatting like *italics* and the following points:

      * My first point is simple
      * But I do have other points to
      * And sometimes I do go on

      To back up my arguments I ensure that I link to official sources like the [APH Official website](http://aph.gov.au).
      --- COMMENTS AND NOTES ---

      (put thoughts and notes for other researchers here)
    TEXT
    create(
      :wiki_motion,
      id: 2,
      division_id: division.id,
      text_body: text_body,
      user_id: user.id,
      created_at: "2014-05-15 08:44:37"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_tony_abbott.id,
      vote: "aye"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_kevin_rudd.id,
      vote: "aye"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_roger_price.id,
      vote: "aye",
      teller: true
    )
    division
  end

  let(:division_senate_2009_11_25_8) do
    division = create(
      :division,
      id: 2037,
      date: "2009-11-25",
      clock_time: "016:13:00",
      number: 8,
      house: "senate",
      name: "Carbon Pollution Reduction Scheme Legislation",
      motion: '<p pwmotiontext="moved">That the question for the third reading of the Carbon Pollution Reduction Scheme Bill&#160;2009&#160;[No. 2] and 10 related bills not be put until the third sitting day in February 2010.</p>',
      debate_gid: "uk.org.publicwhip/lords/2009-11-25.76.2"
    )
    create(
      :division_info,
      division_id: division.id,
      rebellions: 11,
      tells: 2,
      turnout: 65,
      possible_turnout: 76,
      aye_majority: -31
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Greens",
      no_votes: 5,
      possible_votes: 5,
      whip_guess: "no"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Labor Party",
      no_votes: 28,
      no_tells: 1,
      possible_votes: 31,
      whip_guess: "no"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Country Liberal Party",
      possible_votes: 1,
      whip_guess: "unknown"
    )
    create(
      :whip,
      division_id: division.id,
      party: "DPRES",
      aye_votes: 1,
      possible_votes: 1,
      whip_guess: "aye"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Family First Party",
      aye_votes: 1,
      possible_votes: 1,
      whip_guess: "aye"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Independent",
      no_votes: 1,
      possible_votes: 1,
      whip_guess: "none"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Liberal Party",
      aye_votes: 11,
      no_votes: 12,
      possible_votes: 30,
      whip_guess: "no"
    )
    create(
      :whip,
      division_id: division.id,
      party: "National Party",
      aye_votes: 3,
      aye_tells: 1,
      possible_votes: 5,
      whip_guess: "aye"
    )
    create(
      :whip,
      division_id: division.id,
      party: "PRES",
      no_votes: 1,
      possible_votes: 1,
      whip_guess: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christine_milne.id,
      vote: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christopher_back.id,
      vote: "aye"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_judith_adams.id,
      vote: "aye",
      teller: true
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_disagreeable_curmudgeon.id,
      vote: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_surly_nihilist.id,
      vote: "aye"
    )
    division
  end

  let(:division_senate_2009_11_30_8) do
    division = create(
      :division,
      id: 59,
      date: "2009-11-30",
      clock_time: "012:00:00",
      number: 8,
      house: "senate",
      name: "Carbon Pollution Reduction Scheme (Cprs Fuel Credits) Bill 2009 [No. 2]; Carbon Pollution Reduction Scheme Amendment (Household Assistance) Bill 2009 [No. 2] &#8212; Third Reading",
      motion: '<p pwmotiontext="moved">That these bills be now read a third time.</p>',
      debate_gid: "uk.org.publicwhip/lords/2009-11-30.559.1"
    )
    create(
      :division_info,
      division_id: division.id,
      rebellions: 1,
      tells: 2,
      turnout: 73,
      possible_turnout: 76,
      aye_majority: -9
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Greens",
      no_votes: 5,
      possible_votes: 5,
      whip_guess: "no"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Liberal Party",
      aye_votes: 1,
      no_votes: 27,
      no_tells: 1,
      possible_votes: 30,
      whip_guess: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christine_milne.id,
      vote: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christopher_back.id,
      vote: "no"
    )
    division
  end

  # This one used for checking the ordering of divisions by date.
  # Chronologically it is later than division_id 59, but the sql returns it
  # before that division when no orderby clause is used.
  # Unfortunately that behaviour is arbitrary, and changing the test fixtures or
  # the environment will likely change that order. One Solution would be to
  # mock out the sql calls.
  let(:division_senate_2009_12_30_8) do
    division = create(
      :division,
      id: 4444,
      date: "2009-12-30",
      clock_time: "012:00:00",
      number: 8,
      house: "senate",
      name: "Proceedural ban of flatulence during divisions",
      motion: '<p pwmotiontext="moved">That the member for Grayndler stop using biological means to influence the outcome of divisions.</p>',
      debate_gid: "uk.org.publicwhip/lords/2009-11-10.559.1"
    )
    create(
      :division_info,
      division_id: division.id,
      tells: 2,
      turnout: 73,
      possible_turnout: 76,
      aye_majority: -9
    )
    create(
      :whip,
      division_id: division.id,
      party: "Australian Greens",
      aye_votes: 5,
      possible_votes: 5,
      whip_guess: "aye"
    )
    create(
      :whip,
      division_id: division.id,
      party: "Liberal Party",
      aye_votes: 1,
      no_votes: 27,
      no_tells: 1,
      possible_votes: 30,
      whip_guess: "no"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christine_milne.id,
      vote: "aye"
    )
    create(
      :vote,
      division_id: division.id,
      member_id: member_christopher_back.id,
      vote: "no"
    )
    division
  end

  let(:policy1) do
    policy = create(
      :policy,
      id: 1,
      name: "marriage equality",
      user_id: user.id,
      description: "access to marriage should be equal",
      created_at: 1.day.ago,
      updated_at: 1.day.ago
    )
    create(
      :policy_division,
      division_id: division_representatives_2013_03_14_1.id,
      policy_id: policy.id,
      vote: "aye"
    )
    policy
  end

  let(:policy2) do
    policy = create(
      :policy,
      id: 2,
      name: "offshore processing",
      user_id: user.id,
      description: "refugees arrving by boat should be processed offshore",
      created_at: 1.day.ago,
      updated_at: 1.day.ago
    )
    create(
      :policy_division,
      division_id: division_senate_2013_03_14_1.id,
      policy_id: policy.id,
      vote: "no3"
    )
    create(
      :policy_division,
      division_id: division_representatives_2006_12_06_3.id,
      policy_id: policy.id,
      vote: "no"
    )
    policy
  end

  let(:policy3) do
    policy = create(
      :provisional_policy,
      id: 3,
      name: "provisional policies",
      user_id: user.id,
      description: "A provisional policy",
      created_at: 1.day.ago,
      updated_at: 1.day.ago
    )
    create(
      :policy_division,
      division_id: division_senate_2013_03_14_1.id,
      policy_id: policy.id,
      vote: "no3"
    )
    policy
  end

  let(:user) do
    create(
      :confirmed_user,
      id: 1,
      name: "Henare Degan",
      email: "henare@oaf.org.au",
      staff: true
    )
  end

  let(:person_tony_abbott) do
    person = create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10001.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10001.jpg",
      id: 10001
    )
    create(
      :office,
      id: 504,
      position: "Minister for Health and Ageing",
      from_date: "2003-10-7",
      to_date: "2007-12-3",
      person_id: person.id
    )
    create(
      :office,
      id: 1201,
      position: "Shadow Minister for Families, Community Services, Indigenous Affairs and the Voluntary Sector",
      from_date: "2007-12-6",
      to_date: "2008-9-22",
      person_id: person.id
    )
    create(
      :office,
      id: 1202,
      position: "Shadow Minister for Families, Housing, Community Services and Indigenous Affairs",
      from_date: "2008-9-22",
      to_date: "2009-12-8",
      person_id: person.id
    )
    create(
      :office,
      id: 1200,
      position: "Leader of the Opposition",
      from_date: "2009-12-8",
      to_date: "9999-12-31",
      person_id: person.id
    )
    person
  end

  let(:person_kevin_rudd) do
    person = create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10552.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10552.jpg",
      id: 10552
    )
    create(
      :office,
      id: 380,
      position: "Prime Minister",
      from_date: "2013-6-27",
      to_date: "9999-12-31",
      person_id: person.id
    )
    person
  end

  let(:person_christine_milne) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10458.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10458.jpg",
      id: 10458
    )
  end

  let(:person_john_howard) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10313.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10313.jpg",
      id: 10313
    )
  end

  let(:person_maxine_mckew) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10439.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10439.jpg",
      id: 10439
    )
  end

  let(:person_john_alexander) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10725.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10725.jpg",
      id: 10725
    )
  end

  let(:person_christopher_back) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10722.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10722.jpg",
      id: 10722
    )
  end

  let(:person_judith_adams) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10005.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10005.jpg",
      id: 10005
    )
  end

  let(:person_paul_zammit) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10694.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10694.jpg",
      id: 10694
    )
  end

  let(:person_disagreeable_curmudgeon) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/22221.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/22221.jpg",
      id: 22221
    )
  end

  let(:person_surly_nihilist) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/33331.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/33331.jpg",
      id: 33331
    )
  end

  let(:person_roger_price) do
    create(
      :person,
      small_image_url: "https://www.openaustralia.org.au/images/mps/10519.jpg",
      large_image_url: "https://www.openaustralia.org.au/images/mpsL/10519.jpg",
      id: 10519
    )
  end

  let(:member_tony_abbott) do
    member = create(
      :member,
      id: 1,
      first_name: "Tony",
      last_name: "Abbott",
      constituency: "Warringah",
      party: "Liberal Party",
      house: "representatives",
      entered_house: "1994-03-26",
      left_house: "9999-12-31",
      entered_reason: "by_election",
      left_reason: "still_in_office",
      person_id: person_tony_abbott.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 1,
      votes_possible: 2,
      aye_majority: 1
    )
    member
  end

  let(:member_kevin_rudd) do
    member = create(
      :member,
      id: 450,
      first_name: "Kevin",
      last_name: "Rudd",
      constituency: "Griffith",
      party: "Australian Labor Party",
      house: "representatives",
      entered_house: "1998-10-03",
      left_house: "2013-11-22",
      entered_reason: "general_election",
      left_reason: "resigned",
      person_id: person_kevin_rudd.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 2,
      votes_possible: 2
    )
    member
  end

  let(:member_christine_milne) do
    member = create(
      :member,
      id: 100156,
      first_name: "Christine",
      last_name: "Milne",
      constituency: "Tasmania",
      party: "Australian Greens",
      house: "senate",
      entered_house: "2005-07-01",
      left_house: "9999-12-31",
      entered_reason: "general_election",
      left_reason: "still_in_office",
      person_id: person_christine_milne.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 4,
      votes_possible: 4,
      aye_majority: -2
    )
    member
  end

  let(:member_john_howard) do
    member = create(
      :member,
      id: 265,
      first_name: "John",
      last_name: "Howard",
      party: "Liberal Party",
      constituency: "Bennelong",
      house: "representatives",
      entered_house: "1974-05-18",
      left_house: "2007-11-24",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_john_howard.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_possible: 1
    )
    member
  end

  let(:member_maxine_mckew) do
    member = create(
      :member,
      id: 367,
      first_name: "Maxine",
      last_name: "McKew",
      party: "Australian Labor Party",
      constituency: "Bennelong",
      house: "representatives",
      entered_house: "2007-11-24",
      left_house: "2010-08-21",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_maxine_mckew.id
    )
    member
  end

  let(:member_john_alexander) do
    member = create(
      :member,
      id: 589,
      first_name: "John",
      last_name: "Alexander",
      party: "Liberal Party",
      constituency: "Bennelong",
      house: "representatives",
      entered_house: "2010-08-21",
      left_house: "9999-12-31",
      entered_reason: "general_election",
      left_reason: "still_in_office",
      person_id: person_john_alexander.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_possible: 1
    )
    member
  end

  let(:member_christopher_back) do
    member = create(
      :member,
      id: 100279,
      first_name: "Christopher",
      last_name: "Back",
      constituency: "WA",
      party: "Liberal Party",
      house: "senate",
      entered_house: "2009-03-11",
      left_house: "9999-12-31",
      entered_reason: "general_election",
      left_reason: "still_in_office",
      person_id: person_christopher_back.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 3,
      votes_possible: 4,
      aye_majority: -1
    )
    member
  end

  let(:member_judith_adams) do
    member = create(
      :member,
      id: 100002,
      first_name: "Judith",
      last_name: "Adams",
      constituency: "WA",
      party: "Liberal Party",
      house: "senate",
      entered_house: "2005-07-01",
      left_house: "2012-03-31",
      entered_reason: "general_election",
      left_reason: "died",
      person_id: person_judith_adams.id
    )
    create(
      :member_info,
      member_id: member.id,
      tells: 1,
      votes_attended: 1,
      votes_possible: 3,
      aye_majority: 1
    )
    member
  end

  let(:member_paul_zammit) do
    member = create(
      :member,
      id: 562,
      first_name: "Paul",
      last_name: "Zammit",
      constituency: "Lowe",
      party: "Independent",
      house: "representatives",
      entered_house: "1996-03-02",
      left_house: "1998-10-03",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_paul_zammit.id
    )
    member
  end

  let(:member_disagreeable_curmudgeon) do
    member = create(
      :member,
      id: 222222,
      first_name: "Disagreeable",
      last_name: "Curmudgeon",
      constituency: "WA",
      party: "Independent",
      house: "senate",
      entered_house: "1996-03-02",
      left_house: "2010-10-03",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_disagreeable_curmudgeon.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 1,
      votes_possible: 3,
      aye_majority: -1
    )
    member
  end

  let(:member_surly_nihilist) do
    member = create(
      :member,
      id: 333333,
      first_name: "Surly",
      last_name: "Nihilist",
      constituency: "WA",
      party: "Independent",
      house: "senate",
      entered_house: "1996-03-02",
      left_house: "2010-10-03",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_surly_nihilist.id
    )
    create(
      :member_info,
      member_id: member.id,
      votes_attended: 1,
      votes_possible: 3,
      aye_majority: 1
    )
    member
  end

  let(:member_roger_price) do
    member = create(
      :member,
      id: 424,
      first_name: "Roger",
      last_name: "Price",
      constituency: "Chifley",
      party: "Australian Labor Party",
      house: "representatives",
      entered_house: "1984-12-01",
      left_house: "2010-08-21",
      entered_reason: "general_election",
      left_reason: "",
      person_id: person_roger_price.id
    )
    create(
      :member_info,
      member_id: member.id,
      tells: 1,
      votes_attended: 1,
      votes_possible: 1,
      aye_majority: 1
    )
    member
  end

  let(:tony_abbott_tony_abbott) do
    create(
      :people_distance,
      person1_id: person_tony_abbott.id,
      person2_id: person_tony_abbott.id,
      nvotessame: 1
    )
  end

  let(:tony_abbott_john_howard) do
    create(
      :people_distance,
      person1_id: person_tony_abbott.id,
      person2_id: person_john_howard.id,
      distance_b: -1.0
    )
  end

  let(:tony_abbott_maxine_mckew) do
    create(
      :people_distance,
      person1_id: person_tony_abbott.id,
      person2_id: person_maxine_mckew.id,
      distance_b: -1.0
    )
  end

  let(:tony_abbott_kevin_rudd) do
    create(
      :people_distance,
      person1_id: person_tony_abbott.id,
      person2_id: person_kevin_rudd.id,
      nvotessame: 1,
      distance_b: 0.0
    )
  end

  let(:tony_abbott_john_alexander) do
    create(
      :people_distance,
      person1_id: person_tony_abbott.id,
      person2_id: person_john_alexander.id,
      distance_b: -1.0
    )
  end

  let(:john_howard_kevin_rudd) do
    create(
      :people_distance,
      person1_id: person_john_howard.id,
      person2_id: person_kevin_rudd.id,
      distance_b: -1.0
    )
  end

  let(:maxine_mckew_kevin_rudd) do
    create(
      :people_distance,
      person1_id: person_maxine_mckew.id,
      person2_id: person_kevin_rudd.id,
      distance_b: -1.0
    )
  end

  let(:kevin_rudd_kevin_rudd) do
    create(
      :people_distance,
      person1_id: person_kevin_rudd.id,
      person2_id: person_kevin_rudd.id,
      nvotessame: 2,
      distance_b: 0.0
    )
  end

  let(:kevin_rudd_john_alexander) do
    create(
      :people_distance,
      person1_id: person_kevin_rudd.id,
      person2_id: person_john_alexander.id,
      distance_b: -1.0
    )
  end

  let(:christine_milne_christine_milne) do
    create(
      :people_distance,
      person1_id: person_christine_milne.id,
      person2_id: person_christine_milne.id,
      nvotessame: 2,
      distance_b: 0.0
    )
  end

  let(:christine_milne_christopher_back) do
    create(
      :people_distance,
      person1_id: person_christine_milne.id,
      person2_id: person_christopher_back.id,
      nvotesdiffer: 1,
      distance_b: 1.0
    )
  end

  let(:policy1_tony_abbott) do
    create(
      :policy_person_distance,
      policy_id: policy1.id,
      person_id: person_tony_abbott.id,
      nvotesabsent: 1,
      distance_a: 0.5
    )
  end

  let(:policy1_kevin_rudd) do
    create(
      :policy_person_distance,
      policy_id: policy1.id,
      person_id: person_kevin_rudd.id,
      nvotesdiffer: 1,
      distance_a: 1.0
    )
  end

  let(:policy1_john_alexander) do
    create(
      :policy_person_distance,
      policy_id: policy1.id,
      person_id: person_john_alexander.id,
      nvotesabsent: 1,
      distance_a: 0.5
    )
  end
end
