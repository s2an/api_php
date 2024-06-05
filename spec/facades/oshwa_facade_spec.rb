require "rails_helper"

RSpec.describe OshwaFacade do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("oshwa_bearer_token").and_return("test_bearer_token")
  end

  describe "HAPPY PATHS" do
    it "returns a list of projects" do
      json_response = File.read("spec/fixtures/oshwa_get_projects.json")
      stub_request(:get, "https://certificationapi.oshwa.org/api/projects")
        .with(
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer test_bearer_token"
          }
        )
        .to_return(status: 200, body: json_response, headers: {})

      projects = OshwaFacade.get_oshwa_projects
      expect(projects).to be_all(Oshwa)
    end

    it "returns a list of projects when searching" do
      json_response = File.read("spec/fixtures/oshwa_search_projects_keyboard.json")
      stub_request(:get, "https://certificationapi.oshwa.org/api/projects?q=keyboard")
        .with(
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer test_bearer_token"
          }
        )
        .to_return(status: 200, body: json_response, headers: {})

      projects = OshwaFacade.search_oshwa_projects("keyboard")
      expect(projects).to be_all(Oshwa)
    end
  end

  describe "SAD PATHS" do
    it "raises an error when the request fails" do
      stub_request(:get, "https://certificationapi.oshwa.org/api/projects")
        .with(
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer test_bearer_token"
          }
        )
        .to_return(status: 500, body: "Internal Server Error", headers: {})
      
      # find a more verbose way to refactor this
      expect { OshwaFacade.get_oshwa_projects }.to raise_error(RuntimeError, /Error: 500 - /)
    end
  end
  
end
