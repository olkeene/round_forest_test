FROM ruby:2.3.1-slim

RUN apt-get update -qq && \
    apt-get install -y \
      build-essential git \
      postgresql-client libpq-dev --no-install-recommends && \
    apt-get clean

ENV APP /app
ENV BUNDLE_PATH /box

# Gems
RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# App
RUN mkdir $APP
WORKDIR $APP
ADD . $APP

EXPOSE 5000

ENTRYPOINT bin/docker-entrypoint.sh $0 $@
