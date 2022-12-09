class WeatherMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sub.find_each do |sub|
      WeatherMailer.with(sub: sub, weather: ResultServices::Result.new.daily_weather).daily_weather.deliver_now
    end
  end
end
