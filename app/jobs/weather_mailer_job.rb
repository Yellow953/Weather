class WeatherMailerJob < ApplicationJob
  queue_as :default
  
  require 'uri'
  require 'net/http'
  require 'json'
  require 'iplocate'

  def perform(*args)
    # weather_api_key = Rails.application.credentials.config.dig(:weather_api_key)

    # # ----------------------
    # url5 = URI("http://api.ipify.org?format=json")
    # http = Net::HTTP.new(url5.host, url5.port)
    # request5 = Net::HTTP::Get.new(url5)
    # response5 = http.request(request5).body
    # data5 = JSON.parse(response5)
    # ip = data5["ip"]

    # # ----------------------
    # a = IPLocate.lookup(ip)
    # country = a["city"] || a["country"]

    # # ----------------------
    # url1 = URI("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=" + weather_api_key + "&q=" + country + "&commit=Search")   
    # request1 = Net::HTTP::Get.new(url1)
    # response1 = http.request(request1).body
    # data1 = JSON.parse(response1)
        
    # # --------------------
    # @LocalizedName = data1[0]["LocalizedName"]
    # @key = data1[0]["Key"]

    # # --------------------
    # url2 = URI("http://dataservice.accuweather.com/forecasts/v1/daily/1day/" + @key + "?apikey=" + weather_api_key)
    # request2 = Net::HTTP::Get.new(url2)
    # response2 = http.request(request2).body
    # data2 = JSON.parse(response2)
    
    # # --------------------
    # @text = data2["Headline"]["Text"]
    # @category = data2["Headline"]["Category"]
    # @min = (data2["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].to_i - 32) * 5 / 9
    # @max = (data2["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].to_i  - 32) * 5 / 9
    # @avg = (@min + @max) / 2

    # # ---------------------
    # result = Result.new(key: @key, name: @LocalizedName, category: @category, text: @text, average: @avg, minimum: @min, maximum: @max)
    
    # --------------------
    Sub.find_each do |sub|
      WeatherMailer.with(sub: sub, result: Result.last).daily_weather.deliver_later
    end
  end
end
