require "rails_helper"

RSpec.describe OshwaService, type: :service do
  describe ".get_products" do
    context "when the request is successful" do
      before do
        # General stub for ENV to avoid errors from unexpected calls
        allow(ENV).to receive(:[]).and_call_original

        # Specific stub for the bearer token
        allow(ENV).to receive(:[]).with("oshwa_bearer_token").and_return("test_bearer_token")

        # Hit the fixture file instead of the actual API
        json_response = File.read("spec/fixtures/oshwa_get_projects.json")

        # Stub the request to return the fixture file
        stub_request(:get, "https://certificationapi.oshwa.org/api/projects")
        .with(
          body: { bearer_token: "test_bearer_token" }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
        .to_return(status: 200, body: json_response, headers: {})
      end

      it "returns a list of products" do
        projects = OshwaService.get_projects
        expect(projects).not_to be_empty
        expect(projects).to be_a(Hash)
      end
    end

    context "when the request fails" do
      before do
        stub_request(:get, "https://certificationapi.oshwa.org/api/projects")
          .with(headers: { "Content-Type" => "application/json" })
          .to_return(status: 500, body: "Internal Server Error")
      end

      it "raises an error" do
        expect { OshwaService.get_projects }.to raise_error(RuntimeError, /Error: 500/)
      end
    end
  end
end