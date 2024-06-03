class OshwaService

  BASE_URL = "https://certificationapi.oshwa.org"

  def self.get_projects
    response = conn.get("#{BASE_URL}/api/projects") do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{ENV["oshwa_bearer_token"]}"
    end

    if response.success?
      JSON.parse(response.body)
    else
      raise "Error: #{response.status} - #{response.reason_phrase}"
    end
  end

  def self.search_projects(q)
    response = conn.get("/api/projects?q=#{q}") do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{ENV["oshwa_bearer_token"]}"
    end

    if response.success?
      JSON.parse(response.body)
    else
      raise "Error: #{response.status} - #{response.reason_phrase}"
    end
  end

  def self.conn #5
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end