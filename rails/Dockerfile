FROM ruby:2-alpine
RUN apk add --no-cache tzdata nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN apk add --no-cache --virtual build-dependencies build-base mariadb-dev \
  && gem install bundler # \
  && bundle install \
  && apk del build-dependencies
COPY . /app
EXPOSE 8080
CMD tail -f /dev/null # echo $ENVIRONMENT && bundle exec rails s -p 8080 -b 0.0.0.0 -e $ENVIRONMENT
