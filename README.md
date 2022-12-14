<!-- 1 – Get user location from ip address and show that as a default result when page first opens. (gem geocode) -->

<!-- 2 – Add a subscribe field to the bottom of the screen (email). -->
 
<!-- 3 – Add subscribed users to database. -->

<!-- 4 – Use rails cron jobs to send a daily scheduled daily weather report to that email . -->

<!-- 5 -  You can refer to here for your starting point to how to implement cron jobs: https://woetflow.com/posts/sending-mails-with-sidekiq-cron-jobs-in-ruby-on-rails/ -->

<!-- verify fields in model -->

<!-- don't show the new search in last ten searches -->

<!-- 1 -  add error message when email is not valid, check for uniquness -->

<!-- 2 - put a condition to show city if doenst exist show country -->

<!-- install redis -->

<!-- credentials -->
EDITOR="code --wait" rails credentials:edit

<!-- useful links: -->
https://dashboard.render.com/web/srv-cec5orqrrk0506ud5ou0/deploys/dep-cecb6gun6mprhjsqgfi0
https://rubyandrails.info/pages/heroku-alternatives
https://woetflow.com/posts/sending-mails-with-sidekiq-cron-jobs-in-ruby-on-rails/#23-booting-up-sidekiq
https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/cities/neighbors/%7BlocationKey%7D
https://github.com/alexreisner/geocoder
https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/cities/neighbors/%7BlocationKey%7D

<!-- db: -->
postgres://weather:SbXRTscqnUdlftWKw5Umia8P0zpJA2Yt@dpg-cec5kben6mprhjs6q0j0-a/weather_production_ksi0
postgres://weather:SbXRTscqnUdlftWKw5Umia8P0zpJA2Yt@dpg-cec5kben6mprhjs6q0j0-a.frankfurt-postgres.render.com/weather_production_ksi0
PGPASSWORD=SbXRTscqnUdlftWKw5Umia8P0zpJA2Yt psql -h dpg-cec5kben6mprhjs6q0j0-a.frankfurt-postgres.render.com -U weather weather_production_ksi0

<!------------------------------------------------>
http://dataservice.accuweather.com/locations/v1/cities/neighbors/178087
https://crontogo.com
https://cron-job.org/en/