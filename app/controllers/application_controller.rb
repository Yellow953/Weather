class ApplicationController < ActionController::Base
    require 'uri'
    require 'net/http'
    require 'json'
    require 'iplocate'

    def index
        weather_api_key = Rails.application.credentials.config.dig(:weather_api_key)

        if(params[:q])
            url1 = URI("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=" + weather_api_key + "&q=" + params[:q] + "&commit=Search")   
            http = Net::HTTP.new(url1.host, url1.port)
            
            data1 = make_api_request(http, url1)
            if (data1.any?)
                @LocalizedName = data1[0]["LocalizedName"]
                @key = data1[0]["Key"]

                url2 = URI("http://dataservice.accuweather.com/forecasts/v1/daily/1day/" + @key + "?apikey=" + weather_api_key)
                data2 = make_api_request(http, url2)
                if (data2.any?)
                    @text = data2["Headline"]["Text"]
                    @category = data2["Headline"]["Category"]
                    @min = (data2["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].to_i - 32) * 5 / 9
                    @max = (data2["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].to_i  - 32) * 5 / 9
                    @avg = (@min + @max) / 2
                else
                    flash.now[:danger] = "Could not find the weather for this city"
                end    
            else
                flash.now[:danger] = "Could not find this city"
            end

            body = RestClient.get "http://host.docker.internal:3001/results", headers = {accept: :json}
            response = JSON.parse(body)
            @results = response["results"]

            savedata(@key, @LocalizedName, @text, @category, @min, @max, @avg)
        else
            url5 = URI("http://api.ipify.org?format=json")
            http = Net::HTTP.new(url5.host, url5.port)
            
            data5 = make_api_request(http, url5)
            ip = data5["ip"]
            
            country = get_city_or_country(ip)
            redirect_to root_path(q: country)
            
            body = RestClient.get "http://host.docker.internal:3001/results", headers = {accept: :json}
            response = JSON.parse(body)
            @results = response["results"]
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
        body = RestClient.get "http://host.docker.internal:3001/results", headers = {accept: :json}
        response = JSON.parse(body)
        @results = response["results"]
    end
     
    # -----------------------------------------------------------------

    def savedata(key, localizedName, text, category, min, max , avg)
        url =  "http://host.docker.internal:3001/results/new?key=#{key}&name=#{localizedName}&text=#{text}&category=#{category}&minimum=#{min}&maximum=#{max}&average=#{avg}"
        body = RestClient.post url, headers = {accept: :json}
    end
    
    def make_api_request(http, url)
        request = Net::HTTP::Get.new(url)
        response = http.request(request).body
        return JSON.parse(response)
    end
    
    def get_last_results
        return Result.last(10).reverse
    end
    
    def get_city_or_country(ip)
        a = IPLocate.lookup(ip)
        return a["city"] || a["country"]
    end
    
end