require "rails_helper"

RSpec.describe ProductHuntService, type: :service do
  describe ".get_access_token" do
    context "when the request is successful" do
      before do
        stub_request(:post, "https://api.producthunt.com/v2/oauth/token")
          .with(
            body: {
              client_id: ENV["product_hunt_client_id"],
              client_secret: ENV["product_hunt_client_secret"],
              grant_type: "client_credentials"
            }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(
            status: 200,
            body: { access_token: "mock_token" }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
      end
  
      it "returns an access token" do
        token = ProductHuntService.send(:get_access_token)
        expect(token).to be_a(String)
        expect(token).not_to be_empty
      end
    end
  
    context "when the request fails" do
      before do
        stub_request(:post, "https://api.producthunt.com/v2/oauth/token")
          .with(
            body: {
              client_id: ENV["product_hunt_client_id"],
              client_secret: ENV["product_hunt_client_secret"],
              grant_type: "client_credentials"
            }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(status: 500, body: "Internal Server Error")
      end
  
      it "raises an error" do
        expect { ProductHuntService.send(:get_access_token) }.to raise_error(RuntimeError, /Error: 500/)
      end
    end
  end

  describe ".get_products" do
    context "when the request is successful" do
      before do
        
        # Stub the first call for the oauth token
        stub_request(:post, "https://api.producthunt.com/v2/oauth/token")
          .with(
            body: {
              client_id: ENV["product_hunt_client_id"],
              client_secret: ENV["product_hunt_client_secret"],
              grant_type: "client_credentials"
            }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(
            status: 200,
            body: { access_token: "mock_token" }.to_json,
            headers: { "Content-Type" => "application/json" }
          )

        # Stub the second call for the actual products
        stub_request(:get, "https://api.producthunt.com/v1/posts")
          .with(headers: { "Authorization" => "Bearer mock_token" })
          .to_return(
            status: 200,
            body: [{ name: "Product 1" }, { name: "Product 2" }].to_json,
            headers: { "Content-Type" => "application/json" }
          )
      end

      it "returns a list of products" do
        products = ProductHuntService.get_products
        expect(products).not_to be_empty
        expect(products).to be_a(Array)
        expect(products.first).to have_key("name")
      end
    end

    context "when the request fails" do
      before do
        stub_request(:post, "https://api.producthunt.com/v2/oauth/token")
          .with(
            body: {
              client_id: ENV["product_hunt_client_id"],
              client_secret: ENV["product_hunt_client_secret"],
              grant_type: "client_credentials"
            }.to_json,
            headers: { "Content-Type" => "application/json" }
          )
          .to_return(
            status: 200,
            body: { access_token: "mock_token" }.to_json,
            headers: { "Content-Type" => "application/json" }
          )

        stub_request(:get, "https://api.producthunt.com/v1/posts")
          .with(headers: { "Authorization" => "Bearer mock_token" })
          .to_return(status: 500, body: "Internal Server Error")
      end

      it "raises an error" do
        expect { ProductHuntService.get_products }.to raise_error(RuntimeError, /Error: 500/)
      end
    end
  end
end