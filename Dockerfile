# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs npm && npm install -g yarn
WORKDIR yeventcms/
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . .
EXPOSE 3000