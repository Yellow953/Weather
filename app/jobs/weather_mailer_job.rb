class WeatherMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sub.find_each do |sub|
      WeatherMailer.with(sub: sub, result: Result.last).daily_weather.deliver_later
    end
  end
end
