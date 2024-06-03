class OshwaService

  BASE_URL = "https://certificationapi.oshwa.org"

  def self.get_projects
    response = Faraday.get("#{BASE_URL}/api/projects") do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = { bearer_token: ENV["oshwa_bearer_token"] }.to_json
    end

    if response.success?
      JSON.parse(response.body)
    else
      raise "Error: #{response.status} - #{response.reason_phrase}"
    end
  end
end