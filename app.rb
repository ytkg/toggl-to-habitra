require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'faraday'
  gem 'dotenv', require: 'dotenv/load'
end

require_relative './lib/toggl'
require_relative './lib/habitra'

def check_environment_variables
  %w/TOGGL_API_TOKEN TOGGL_WORKSPACE_ID HABITRA_ID HABITRA_PASSWORD/.each do |environment_variable_name|
    raise "Missing required environment variable #{environment_variable_name}" if ENV[environment_variable_name].to_s.empty?
  end
end

def fetch_summary(date)
  toggl = Toggl::Client.new(ENV['TOGGL_API_TOKEN'])
  params = { workspace_id: ENV['TOGGL_WORKSPACE_ID'], since: date, until: date }
  toggl.summary(params)
end

def fetch_complated_habit_names
  date = Date.today
  summary = fetch_summary(date)
  summary[:data].map { _1[:title][:project] }
end

def habitra
  @habitra ||= Habitra::Client.new(ENV['HABITRA_ID'], ENV['HABITRA_PASSWORD'])
end

def fetch_habits
  @habits ||= habitra.list_habit[:habits]
end

def fetch_habit_id(habit_name)
  habit = fetch_habits.find { |habit| habit[:name] == habit_name }
  habit[:id] if habit
end

def track_habit(habit_id)
  habitra.create_track(habit_id)
end

check_environment_variables

complated_habit_names = fetch_complated_habit_names
complated_habit_names.each do |habit_name|
  habit_id = fetch_habit_id(habit_name)
  track_habit(habit_id)
end
