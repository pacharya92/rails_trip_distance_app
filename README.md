# Trip Distance App

Simple web app that calculates the distance and travel_time between locations

## Technologies Used
- Ruby 2.7.1
- Rails 7 
- Hotwire Turbo(StimulusJS and Turbo Frames)
- TailwindCSS 

## Install

### Clone the repository

```shell
git clone git@github.com:pacharya92/rails_trip_distance_app.git
```

### Check your Ruby version

```shell
ruby -v
```

The output should start with something like `ruby 2.7.1` higher versions are fine 

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.7.1
```

### Install dependencies

Install [Node](https://nodejs.org/en/) `16.15.1` or higher 

Using [Bundler](https://github.com/bundler/bundler) and [NPM](https://nodejs.org/en/):

```shell
bundle install && npm install
```

### Set environment variables
- Create a `.env` file at the root of the project folder
- Get a [GOOGLE_MAPS_API_KEY](https://developers.google.com/maps)
- Add `GOOGLE_MAPS_API_KEY=enter_google_api_key_here` to `.env` file

### Initialize the database

```shell
- rails db:create 
- rails db:migrate 
- rails db:seed (This is optional creates it user's with trips already populated)
```

## Serve

```shell
rails s
```

