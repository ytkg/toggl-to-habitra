module Habitra
  class Client
    attr_reader :user_id, :user_password

    def initialize(user_id, user_password)
      @user_id = user_id
      @user_password = user_password
    end

    def list_habit
      url = "https://api.habitra.io/v1/users/#{user_id}/habits"
      headers = { 'Authorization' => "Basic #{Base64.encode64("#{user_id}:#{user_password}")}" }
      res = Faraday.get(url, nil, headers)

      JSON.parse(res.body, symbolize_names: true)
    end

    def create_track(habit_id)
      url = "https://api.habitra.io/v1/users/#{user_id}/habits/#{habit_id}/tracks"
      headers = { 'Authorization' => "Basic #{Base64.encode64("#{user_id}:#{user_password}")}" }
      res = Faraday.post(url, nil, headers)

      JSON.parse(res.body, symbolize_names: true)
    end
  end
end
