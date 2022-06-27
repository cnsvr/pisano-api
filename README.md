# PISANO ASSIGNMENT
### Description
Pisano is a Customer Experience Management company. We achieve our goal by collecting feedback on our customers’ behalf and delivering meaningful reports for them. In order to find out your inclination towards our tools and domain, we are giving you a simple task that will collect feedback.
### Built With
- Ruby, Ruby on Rails
- PostgreSQL
- Docker

####  Installation
To run with Docker
 - git clone https://github.com/cnsvr/pisano-api
 - cd pisano-api
 - docker-compose up

It will serve on the http://0.0.0.0:3000

All endpoints are available at http://0.0.0.0:3000/api-docs

#### Testing
To run tests
 - set the host as localhost on config/database.yml
 - comment out the username and password in config/database.yml
 - bundle install
 - rails db:create
 - rails db:migrate RAILS_ENV=test
 - bundle exec rspec

Coverage Report is available at /coverage/index.html
