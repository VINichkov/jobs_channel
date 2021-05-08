FROM ruby:3-alpine3.13
WORKDIR /real_estate
RUN apk -U add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    imagemagick \
    tzdata \
    less
COPY Gemfile /real_estate/Gemfile
COPY Gemfile.lock /real_estate/Gemfile.lock
RUN bundle install
EXPOSE 3000
CMD ["rails", "server"]