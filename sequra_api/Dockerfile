FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /sequra_api
WORKDIR /sequra_api
COPY Gemfile /sequra_api/Gemfile
COPY Gemfile.lock /sequra_api/Gemfile.lock
RUN mkdir -p /sequra_api/log && touch /sequra_api/log/development.log
RUN gem install bundler
RUN bundle install
COPY . /sequra_api
RUN gem install foreman