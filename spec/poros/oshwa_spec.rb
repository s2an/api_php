require "rails_helper"

RSpec.describe Oshwa do
  let(:data) do
    {
      "oshwaUid" => "SE000004",
      "responsibleParty" => "arturo182",
      "country" => "Sweden",
      "publicContact" => "oledpmod@solder.party",
      "projectName" => "0.95\" OLED PMOD",
      "projectWebsite" => "https://github.com/arturo182/pmod_rgb_oled_0.95in/",
      "projectVersion" => "1.0",
      "projectDescription" => "A small OLED display",
      "primaryType" => "Hardware",
      "additionalType" => "PMOD",
      "projectKeywords" => "oled, pmod, rgb, 0.95in",
      "hardwareLicense" => "CERN-OHL-P-2.0",
      "softwareLicense" => "MIT",
      "documentationLicense" => "CC-BY-SA-4.0",
      "certificationDate" => "2021-07-01"
    }
  end

  # Creates an instance of the class being described!
  subject { described_class.new(data) }

  describe "HAPPY PATHS" do
    it "initializes with correct attributes" do
      expect(subject.oshwa_uid).to eq("SE000004")
      expect(subject.responsible_party).to eq("arturo182")
      expect(subject.country).to eq("Sweden")
      expect(subject.public_contact).to eq("oledpmod@solder.party")
      expect(subject.project_name).to eq("0.95\" OLED PMOD")
      expect(subject.project_website).to eq("https://github.com/arturo182/pmod_rgb_oled_0.95in/")
      expect(subject.project_version).to eq("1.0")
      expect(subject.project_description).to eq("A small OLED display")
      expect(subject.primary_type).to eq("Hardware")
      expect(subject.additional_type).to eq("PMOD")
      expect(subject.project_keywords).to eq("oled, pmod, rgb, 0.95in")
      expect(subject.hardware_license).to eq("CERN-OHL-P-2.0")
      expect(subject.software_license).to eq("MIT")
      expect(subject.documentation_license).to eq("CC-BY-SA-4.0")
      expect(subject.certification_date).to eq("2021-07-01")
    end
  end

  describe "SAD PATHS" do
    # ??
  end  
end
