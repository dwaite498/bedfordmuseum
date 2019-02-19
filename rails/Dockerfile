FROM ruby:2.6.1-alpine3.9
RUN apk add --no-cache tzdata nodejs mariadb-connector-c
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN apk add --no-cache --virtual build-dependencies build-base mariadb-connector-c-dev \
  && gem install bundler \
  && bundle install \
  && apk del build-dependencies
COPY . /app
EXPOSE 8080
CMD echo $ENVIRONMENT && bundle exec rails s -p 8080 -b 0.0.0.0 -e $ENVIRONMENT
