class WeatherMailer < ApplicationMailer
    def daily_weather
        @sub = params[:sub]
        @weather = params[:weather]
        mail(to: @sub.email, subject: "Daily weather")       
    end
end