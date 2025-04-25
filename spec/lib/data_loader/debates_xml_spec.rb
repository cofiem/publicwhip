# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

describe DataLoader::DebatesXml do
  context "with actual division 1 from representatives on 2009-11-25" do
    subject(:division) do
      xml_document = Nokogiri.parse(File.read(File.expand_path("../../fixtures/2009-11-25.xml", __dir__)))
      described_class.new(xml_document, "representatives").divisions.first
    end

    it { expect(division.date).to eq("2009-11-25") }
    it { expect(division.number).to eq("1") }
    it { expect(division.house).to eq("representatives") }
    it { expect(division.name).to eq("Social Security and Other Legislation Amendment (Income Support for Students) Bill 2009 [No. 2] &#8212; Second Reading") }
    it { expect(division.source_url).to eq("http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:chamber/hansardr/2009-11-25/0000") }
    it { expect(division.debate_url).to eq("http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:chamber/hansardr/2009-11-25/0000") }
    it { expect(division.debate_gid).to eq("uk.org.publicwhip/debate/2009-11-25.101.1") }
    it { expect(division.motion).to eq("<p pwmotiontext=\"moved\">That this bill be now read a second time.</p>\n\n<p pwmotiontext=\"moved\">That all words after &#8220;That&#8221; be omitted with a view to substituting the following words:&#8220;the House:<dl><dt>(1)</dt><dd>registers its dismay that this legislation cuts out the &#8216;gap year&#8217; pathway to Independent Youth Allowance for students who must leave home to attend University, requiring that students instead find 30 hours employment per week for 18 months in order to gain Independent Youth Allowance;</dd><dt>(2)</dt><dd>registers its concern that this legislation will lead to the retrospective removal of access to Youth Allowance for a number of students who undertook a &#8216;gap year&#8217; in 2009 on the basis of advice from Government officials, including teachers, careers advisers and Centrelink officials; and</dd><dt>(3)</dt><dd>urges the Government to:<dl><dt>(a)</dt><dd>offer further amendments that will remove all of the negative retrospective effects of this legislation; and</dd><dt>(b)</dt><dd>provide a reasonable pathway to gaining Independent Youth Allowance for those students who must leave home in order to participate in Higher Education.</dd></dl></dd></dl></p>\n\n<p pwmotiontext=\"moved\">That the words proposed to be omitted (<b>Mr Pyne&#8217;s</b> amendment) stand part of the question.</p>\n\n") }
    it { expect(division.clock_time).to eq("019:26:00") }
    it { expect(division.bills).to eq([{ id: "r5327", url: "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5327", title: "A bill to support mongeese" }]) }
  end

  context "with actual division 1 from senate on 2007-09-11" do
    subject(:division) do
      xml_document = Nokogiri.parse(File.read(File.expand_path("../../fixtures/2007-09-11.xml", __dir__)))
      described_class.new(xml_document, "senate").divisions.first
    end

    it "#motion should support missing pwmotiontext" do
      person = create(:person)
      # FIXME: Create this with a factory
      Member.create!(gid: "uk.org.publicwhip/lord/100003", first_name: "Lyn", last_name: "Allison", source_gid: "",
                     title: "", constituency: "", party: "", house: "",
                     person: person)
      expect(division.motion).to eq("<p class=\"speaker\">Lyn Allison</p>\n\n<p>I move:</p>\n\n<dl><dt></dt><dd>That the Senate&#8212;<dl><dt>(a)</dt><dd>notes that the Medical University of South Carolina has conducted a sophisticated meta-analysis of 17 research papers covering 136 nuclear sites throughout the Western World with the following findings:<dl><dt>(i)</dt><dd>death rates from leukaemia for children up to 9 years of age were between 5 per cent and 24 per cent higher depending on their proximity to nuclear facilities,</dd><dt>(ii)</dt><dd>death rates from leukaemia for those up to 25 years of age were 2&#160;per cent to 18 per cent higher, and</dd><dt>(iii)</dt><dd>incidence rates of leukaemia were increased by 14 per cent to 21&#160;per&#160;cent in zero to 9 year olds and 7 to 10 per cent in zero to 25&#160;year olds;</dd></dl></dd><dt>(b)</dt><dd>considers that research such as this shows the health impact of nuclear activity; and</dd><dt>(c)</dt><dd>urges the Government not to proceed with uranium enrichment or nuclear power reactors in Australia in the light of this research.</dd></dl></dd></dl><p>Question put.</p>\n\n ")
    end

    describe "#bills" do
      it { expect(division.bills).to eq [] }
    end
  end

  describe "#bills" do
    it do
      division_xml = Nokogiri::XML("<division></division>")
      expect(DataLoader::DivisionXml.new(division_xml, "representatives").bills).to be_empty
    end

    it do
      division_xml = Nokogiri::XML("<division><bills><bill id='r5327' url='http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5327'>Some text</bill></bills></division>")
      expect(DataLoader::DivisionXml.new(division_xml, "representatives").bills).to eq [{ id: "r5327", url: "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5327", title: "Some text" }]
    end

    it do
      division_xml = Nokogiri::XML("<division><bills><bill id='r5254' url='http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5254'>Foo</bill><bill id='r5305' url='http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5305'>Bar</bill><bill id='r5303' url='http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5303'>Twist</bill></bills></division>")
      expect(DataLoader::DivisionXml.new(division_xml, "representatives").bills).to eq([
                                                                                         { id: "r5254", url: "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5254", title: "Foo" },
                                                                                         { id: "r5305", url: "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5305", title: "Bar" },
                                                                                         { id: "r5303", url: "http://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;query=Id:legislation/billhome/r5303", title: "Twist" }
                                                                                       ])
    end
  end

  describe "#clock_time" do
    it "adds preceeding zero and trailing seconds" do
      division_xml = instance_double("Division XML", attr: "12:34")
      expect(DataLoader::DivisionXml.new(division_xml, "representatives").clock_time).to eq("012:34:00")
    end

    it "is blank when time is malformed" do
      division_xml = instance_double("Division XML", attr: "foobar")
      expect(DataLoader::DivisionXml.new(division_xml, "representatives").clock_time).to eq("")
    end
  end

  describe "#name" do
    subject(:division) { DataLoader::DivisionXml.new(double, "senate") }

    it "joins major and minor headings" do
      allow(division).to receive(:major_heading).and_return("FOO")
      allow(division).to receive(:minor_heading).and_return("BAR")
      expect(division.name).to eq("Foo &#8212; Bar")
    end

    it "shows major heading only" do
      allow(division).to receive(:major_heading).and_return("FOO")
      allow(division).to receive(:minor_heading).and_return("")
      expect(division.name).to eq("Foo")
    end

    it "shows minor heading only" do
      allow(division).to receive(:major_heading).and_return("")
      allow(division).to receive(:minor_heading).and_return("BAR")
      expect(division.name).to eq("Bar")
    end

    it "correctly capitalises hyphenated titles" do
      allow(division).to receive(:major_heading).and_return("ASIA-PACIFIC ECONOMIC COOPERATION")
      allow(division).to receive(:minor_heading).and_return("")
      expect(division.name).to eq("Asia-Pacific Economic Cooperation")
    end

    it "html encodes and pads em dashes" do
      allow(division).to receive(:major_heading).and_return("CARBON POLLUTION REDUCTION SCHEME (CHARGES—GENERAL) BILL 2009 [NO. 2]")
      allow(division).to receive(:minor_heading).and_return("")
      expect(division.name).to eq("Carbon Pollution Reduction Scheme (Charges &#8212; General) Bill 2009 [No. 2]")
    end

    it "does not lower case first words of minor headings" do
      allow(division).to receive(:major_heading).and_return("FUTURE FUND BILL 2005 ")
      allow(division).to receive(:minor_heading).and_return("In Committee ")
      expect(division.name).to eq("Future Fund Bill 2005 &#8212; In Committee")
    end
  end
end
