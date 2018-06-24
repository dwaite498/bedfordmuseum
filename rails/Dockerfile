FROM ruby:2-alpine
RUN apk add --no-cache tzdata libpq nodejs imagemagick
RUN mkdir /rails
WORKDIR /rails
COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock
RUN apk add --no-cache --virtual build-dependencies build-base postgresql-dev \
  && gem install bundler \
  && bundle install \
  && apk del build-dependencies
COPY . /rails
EXPOSE 8080
CMD ["bundle", "exec", "rails", "s", "-p", "8080", "-b", "0.0.0.0"]
