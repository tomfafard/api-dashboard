require "net/http"
require "json"
require "dotenv"
require "pry"

Dotenv.load

class News

  def initialize
    @key = ENV["NY_TIMES_API_KEY"]
    @the_news = get_news
  end



  #private

  def get_news
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def uri
    URI("http://api.nytimes.com/svc/topstories/v1/technology.json&api-key=#{@key}")
  end
end
