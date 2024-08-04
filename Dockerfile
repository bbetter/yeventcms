# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm && npm install -g yarn

# Set the working directory
WORKDIR eventcms/

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

RUN rails db:migrate

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]