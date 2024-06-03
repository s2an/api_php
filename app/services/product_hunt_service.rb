class ProductHuntService
  BASE_URL = "https://api.producthunt.com/v1"
  TOKEN_URL = "https://api.producthunt.com/v2/oauth/token"

  def self.get_products
    access_token = get_access_token

    response = Faraday.get("#{BASE_URL}/posts") do |req|
      req.headers["Accept"] = "application/json"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{access_token}"
    end

    if response.success?
      JSON.parse(response.body)
    else
      raise "Error: #{response.status} - #{response.reason_phrase}"
    end
  end

  private

  def self.get_access_token
    response = Faraday.post(TOKEN_URL) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = {
        client_id: ENV["product_hunt_client_id"],
        client_secret: ENV["product_hunt_client_secret"],
        grant_type: "client_credentials"
      }.to_json
    end

    if response.success?
      JSON.parse(response.body)["access_token"]
    else
      raise "Error: #{response.status} - #{response.reason_phrase}"
    end
  end
end
