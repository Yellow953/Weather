class ApplicationController < ActionController::Base
    require 'uri'
    require 'net/http'
    require 'json'
    require 'iplocate'

    def index
        weather_api_key = Rails.application.credentials.config.dig(:weather_api_key)

        # -------------------------------
        if(params[:q])
            url1 = URI("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=" + weather_api_key + "&q=" + params[:q] + "&commit=Search")   
            http = Net::HTTP.new(url1.host, url1.port)
            request1 = Net::HTTP::Get.new(url1)

            response1 = http.request(request1).body
            data1 = JSON.parse(response1)
            if (data1 != [])
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
            else
                flash.now[:danger] = "Could not find this city"
            end

            # ----------------------------
            @results = Result.last(10).reverse

            # ----------------------------
            @result = Result.new(key: @key, name: @LocalizedName, text: @text, category: @category, minimum: @min, maximum: @max, average: @avg)
            if @result.save
                flash.now[:success] = "Success..."    
            end
        else
            # ----------------------------
            url5 = URI("http://api.ipify.org?format=json")
            http = Net::HTTP.new(url5.host, url5.port)
            request5 = Net::HTTP::Get.new(url5)
            response5 = http.request(request5).body
            data5 = JSON.parse(response5)
            ip = data5["ip"]
            
            # -----------------------------
            a = IPLocate.lookup(ip)
            country = a["city"] || a["country"]
            redirect_to root_path(q: country)

            # -----------------------------
            @results = Result.last(10).reverse
        end
    end

    def subscribe
        @sub = Sub.new(email: params[:email])
        if @sub.save
            flash[:success] = "user added to subscribers list..."
        else
            flash[:danger] = "Couldn't add user to subscribers list..."
        end
        redirect_to root_path
    end

    def daily_weather
        Sub.all.each do |s|
            WeatherMailer.with(sub: s, result: Result.last).daily_weather.deliver_now 
            @sub = s
            @result = Result.last
        end
        render "weather_mailer/daily_weather"
    end

    def test
        WeatherMailer.with(sub: Sub.second, weather: Result.first).daily_weather.deliver_now 
        @weather = Result.last
        render "weather_mailer/daily_weather"
    end
     
end