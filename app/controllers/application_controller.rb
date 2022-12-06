class ApplicationController < ActionController::Base
    require 'uri'
    require 'net/http'
    require 'json'

    def index
        if(params[:q])
            url = URI("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=" + params[:apikey] + "&q=" + params[:q] + "&commit=Search")       
            http = Net::HTTP.new(url.host, url.port)
            request = Net::HTTP::Get.new(url)

            response = http.request(request).body
            @data = JSON.parse(response)
        
        else
            @data = []
        end
    end

end