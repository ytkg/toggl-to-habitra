module Toggl
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def summary(params = {})
      url = 'https://api.track.toggl.com/reports/api/v2/summary'
      headers = { 'Authorization' => "Basic #{Base64.encode64("#{token}:api_token")}" }
      response = Faraday.get(url, params.merge({ user_agent: 'aaaa' }), headers)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
