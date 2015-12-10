require "./lib/geolocation"
require "./lib/wunderground"
require "./lib/news"
require "./lib/events"
require "sinatra/base"
require "pry"

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    #@ip = "50.241.127.209"
    @geolocation = Geolocation.new(@ip)
    erb :dashboard
  end

  get("/weather") do
    @ip = request.ip
    #@ip = "50.241.127.209"
    @weather = Weather.new(@ip)
    erb :weather
  end

  get("/events") do
    @ip = request.ip
    @events = Events.new(@ip)
    erb :events
  end

  get("/news") do
    @news = News.new
    binding.pry
    erb :news
  end
end
