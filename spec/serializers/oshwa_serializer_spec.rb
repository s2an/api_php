require "rails_helper"

RSpec.describe OshwaSerializer do
  describe "HAPPY PATHS" do
    it "serializes a single Oshwa object" do
      oshwa = Oshwa.new(
        "id" => 1,
        "oshwaUid" => "ABC123",
        "responsibleParty" => "John Doe",
        "country" => "USA",
        "publicContact" => "contact@example.com",
        "projectName" => "Test Project",
        "projectWebsite" => "https://testproject.com",
        "projectVersion" => "1.0",
        "projectDescription" => "A test project",
        "primaryType" => "Type1",
        "additionalType" => "Type2",
        "projectKeywords" => ["test", "project"],
        "hardwareLicense" => "License1",
        "softwareLicense" => "License2",
        "documentationLicense" => "License3",
        "certificationDate" => "2023-01-01"
      )

      serializer = OshwaSerializer.new(oshwa)
      serialized_oshwa = serializer.serializable_hash

      expect(serialized_oshwa[:data][:id]).to eq("1")
      expect(serialized_oshwa[:data][:type]).to eq(:oshwa)
      expect(serialized_oshwa[:data][:attributes]).to include(
        name: "Test Project",
        website: "https://testproject.com",
        description: "A test project"
      )
    end
  end

  describe "SAD PATHS" do
    it "serializes an Oshwa object with missing attributes" do
      oshwa = Oshwa.new(
        "id" => 1,
        "oshwaUid" => nil,
        "responsibleParty" => nil,
        "country" => "USA",
        "publicContact" => nil,
        "projectName" => nil,  # Missing name
        "projectWebsite" => "https://testproject.com",
        "projectVersion" => nil,
        "projectDescription" => "A test project",
        "primaryType" => nil,
        "additionalType" => nil,
        "projectKeywords" => nil,
        "hardwareLicense" => nil,
        "softwareLicense" => nil,
        "documentationLicense" => nil,
        "certificationDate" => nil
      )

      serializer = OshwaSerializer.new(oshwa)
      serialized_oshwa = serializer.serializable_hash

      expect(serialized_oshwa[:data][:id]).to eq("1")
      expect(serialized_oshwa[:data][:type]).to eq(:oshwa)
      expect(serialized_oshwa[:data][:attributes]).to include(
        website: "https://testproject.com",
        description: "A test project"
      )
      expect(serialized_oshwa[:data][:attributes][:name]).to be_nil
    end

    it "handles unexpected data types gracefully" do
      oshwa = Oshwa.new(
        "id" => "not_a_number",  # Invalid data type for ID
        "oshwaUid" => "ABC123",
        "responsibleParty" => "John Doe",
        "country" => "USA",
        "publicContact" => "contact@example.com",
        "projectName" => "Test Project",
        "projectWebsite" => "https://testproject.com",
        "projectVersion" => "1.0",
        "projectDescription" => "A test project",
        "primaryType" => "Type1",
        "additionalType" => "Type2",
        "projectKeywords" => ["test", "project"],
        "hardwareLicense" => "License1",
        "softwareLicense" => "License2",
        "documentationLicense" => "License3",
        "certificationDate" => "2023-01-01"
      )

      serializer = OshwaSerializer.new(oshwa)
      serialized_oshwa = serializer.serializable_hash

      expect(serialized_oshwa[:data][:id]).to eq("not_a_number")
      expect(serialized_oshwa[:data][:type]).to eq(:oshwa)
      expect(serialized_oshwa[:data][:attributes]).to include(
        name: "Test Project",
        website: "https://testproject.com",
        description: "A test project"
      )
    end
  end
end
