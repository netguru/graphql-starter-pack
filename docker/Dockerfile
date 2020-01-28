FROM ruby:2.6.5-alpine as Builder

ENV APP_HOME=/app
ENV GEM_HOME=/bundle
ENV PATH $GEM_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    imagemagick \
    nodejs \
    yarn \
    tzdata

RUN mkdir -p $APP_HOME

WORKDIR ${APP_HOME}

# Install gems

ADD Gemfile* /app/
RUN gem install bundler:2.0.2
RUN bundle config --global frozen 1 \
    && bundle install -j4 --retry 3

# Install yarn packages
COPY package.json yarn.lock /app/
RUN yarn install

RUN bundle config --global path $GEM_HOME
RUN bundle config --global bin $GEM_HOME/bin
RUN bundle config --global frozen 0

ADD . $APP_HOME/

# Precompile assets
RUN bundle exec rake assets:precompile

###############################
# Stage Final
FROM ruby:2.6.5-alpine
# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client \
    tzdata \
    file

RUN gem install bundler:2.0.2

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder /app /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

WORKDIR /app

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    imagemagick \
    nodejs \
    yarn \
    tzdata
RUN bundle install

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
CMD ["docker/startup.sh"]
