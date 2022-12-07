class ApplicationController < ActionController::Base
    require 'uri'
    require 'net/http'
    require 'json'

    def index
        weather_api_key = "s2web36mbNp5li8Jevjj9eHqWQHu2QU0"
        if(params[:q])
            url1 = URI("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=" + weather_api_key + "&q=" + params[:q] + "&commit=Search")   
            http = Net::HTTP.new(url1.host, url1.port)
            request1 = Net::HTTP::Get.new(url1)

            response1 = http.request(request1).body
            data1 = JSON.parse(response1)
        
            @LocalizedName = data1[0]["LocalizedName"]
            @key = data1[0]["Key"]

            url2 = URI("http://dataservice.accuweather.com/forecasts/v1/daily/1day/" + @key + "?apikey=" + weather_api_key)
            request2 = Net::HTTP::Get.new(url2)
            response2 = http.request(request2).body
            data2 = JSON.parse(response2)
        
            @text = data2["Headline"]["Text"]
            @category = data2["Headline"]["Category"]
            @min = (data2["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].to_i - 32) * 5 / 9
            @max = (data2["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].to_i  - 32) * 5 / 9
            @avg = (@min + @max) / 2

            # ------------------------
            @result = Result.create(key: @key, name: @LocalizedName, text: @text, category: @category, minimum: @min, maximum: @max, average: @avg)
            if @result.save
                flash.now[:success] = "Success..."    
            end
        else
            @results = Result.order('created_at DESC')
        end
    end
end