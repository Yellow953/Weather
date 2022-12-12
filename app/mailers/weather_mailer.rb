class WeatherMailer < ApplicationMailer
    def daily_weather
        @sub = params[:sub]
        @result = params[:result]
        mail(to: @sub.email, subject: "Daily weather")       
    end
end