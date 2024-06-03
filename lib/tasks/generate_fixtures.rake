namespace :test do
  task :generate_fixtures, [:base_url, :endpoint] => :environment do |t, args|
    require 'json'
    require 'fileutils'

    if args[:base_url].nil? || args[:endpoint].nil?
      puts "❗Failure: Both base_url and endpoint must be provided."
      exit 1
    end

    base_url = args[:base_url]
    endpoint = args[:endpoint]

    url = base_url + endpoint
    response = Faraday.get(url)
    data = JSON.parse(response.body)

    filename = endpoint.gsub(/\//, '_').gsub(/^\_/, '') + ".json"
    fixtures_dir = Rails.root.join("spec", "fixtures")
    FileUtils.mkdir_p(fixtures_dir)
    file_path = fixtures_dir.join(filename)
    
    File.open(file_path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end

    puts "📬 Fixture generated: #{file_path}"
  end
end