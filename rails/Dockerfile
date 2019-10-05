FROM ruby:2-alpine
RUN apk add --no-cache tzdata nodejs mariadb-connector-c
RUN mkdir /app
WORKDIR /app
COPY . /app
ENV RAILS_ENV=production
RUN apk add --no-cache --virtual build-dependencies build-base mariadb-dev yarn \
  && gem install bundler \
  && bundle install --without development test \
  && bundle exec rails assets:precompile \
  && apk del build-dependencies
EXPOSE 8080
CMD echo $RAILS_ENV && bundle exec rails s -p 8080 -b 0.0.0.0
