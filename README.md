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
<!-- https://dashboard.render.com/web/srv-cec5orqrrk0506ud5ou0/deploys/dep-cecb6gun6mprhjsqgfi0
https://rubyandrails.info/pages/heroku-alternatives
https://woetflow.com/posts/sending-mails-with-sidekiq-cron-jobs-in-ruby-on-rails/#23-booting-up-sidekiq
https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/cities/neighbors/%7BlocationKey%7D
https://github.com/alexreisner/geocoder
https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/cities/neighbors/%7BlocationKey%7D -->

<!------------------------------------------------>
<!-- ip address from user agent
cron job 
mailer setup -->

<!-- 1 - Separate your method by their function -->
<!-- 2 - create fallbacks for responses -->
<!-- 3 - complete tests -->

<!-- create a new rails api inside docker -->
<!-- create a dump file from your old weather app -->
upload this dump file to your new api
connect the frontend of the old weather app to new api

<!-- useful commands -->
docker-compose run --rm web bundle exec rails db:migrate
docker-compose exec db pg_dump -U root password --no-owner | gzip -9  > weather_development_backup.sql
docker-compose exec db pg_restore -C -d weatherapidb_development weather_development_backup.sql 
docker-compose run db ls
