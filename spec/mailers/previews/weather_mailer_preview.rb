class WeatherMailerPreview < ActionMailer::Preview
    def daily_weather
      WeatherMailer.with(sub: Sub.all.sample, weather: Result.new.daily_weather).daily_weather
    end
end