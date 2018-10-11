# README

TLDR: A quick and simple MVP using locationiq API. Initial plan was to use Rack or Sinatra for it, but due to time constraints it.. changed [*]

**Ruby** 2.5.1 
**Rails** 5.2.1

**Configuration**

Simply run:

```
bundle install
cp .env.development.sample .env.development
cp .env.test.sample .env.test
```

and provide:

  - the token you wish to use for the API endpoint
  - https://locationiq.com endpoint which you want to use
  - key for https://locationiq.com API

**Running tests**

Project uses RSpec, to tests can be run via: ```bundle exec rspec``` in the project folder.

So far app does not use any additional services - plain Ruby and Rails.