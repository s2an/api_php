require "rails_helper"

RSpec.describe "Oshwa index page", type: :feature do
  describe "HAPPY PATHS" do
    it "should show the title" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("oshwa_bearer_token").and_return("test_bearer_token")

      json_response = File.read("spec/fixtures/oshwa_get_projects.json")
      stub_request(:get, "https://certificationapi.oshwa.org/api/projects")
      .with(
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer test_bearer_token"
        }
        )
        .to_return(status: 200, body: json_response, headers: {})
                
        visit oshwas_path

        expect(page).to have_content("OSHWA Certified Projects")
    end
  end
end