require "rest-client"

class ChinachuClient::Client
  def initialize(base_url)
    @base_url = "#{base_url}/api"
  end

  def recorded_programs
    response = RestClient.get("#{@base_url}/recorded.json")
    fail "Cannot get recorded programs (Status: #{recsponse.code})" unless response.code == 200

    JSON.parse(response.body).map do |r|
      program = ChinachuClient::Program.parse_from(r)
      program
    end
  end
end
