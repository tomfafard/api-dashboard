require "net/http"
require "json"
require "dotenv"
require "pry"
require_relative "geolocation"

Dotenv.load

class Weather

  attr_reader :the_weather, :city_location, :state_location

  def initialize(ip)
    @ip = ip
    @key = ENV["WUNDERGROUND_API_KEY"]
    @city_location = this_location.city
    @state_location = this_location.state_code
    @the_weather = get_weather
  end

  def this_location
    location = Geolocation.new(@ip)
  end

  def weather_description
    @the_weather["current_observation"]["weather"]
  end

  def temp
    @the_weather["current_observation"]["temp_f"]
  end

  def weather_icon
    @the_weather["current_observation"]["icon_url"]
  end

  private

  def get_weather
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def uri
    URI("http://api.wunderground.com/api/#{@key}/conditions/q/#{@state_location}/#{@city_location}.json")
  end
end
