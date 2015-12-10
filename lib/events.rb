require "net/http"
require "json"
require "pry"
require 'date'
require_relative "geolocation"


class Events

  attr_reader :events_list

  def initialize(ip)
    @ip = ip
    @city_location = this_location.city
    @state_location = this_location.state_code
    @today = Date.today
    @tomorrow = Date.today+4
    @events_list = get_events
  end

  def this_location
    location = Geolocation.new(@ip)
  end

  def all_events
    events = []
    @events_list["events"].each do |event|
      events << { title: event["title"], when: event["datetime_local"] }
    end
    events
  end


  private

  def get_events
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def uri
    url = "http://api.seatgeek.com/2/events"
    url += "?venue.city=#{@city_location}"
    url += "&venue.state=#{@state_location}"
    url += "&datetime_local.gte=#{@today}"
    URI(url)
  end
end
