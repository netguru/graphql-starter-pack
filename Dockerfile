FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rnd_fashion_store_backend
WORKDIR /rnd_fashion_store_backend
COPY Gemfile /rnd_fashion_store_backend/Gemfile
COPY Gemfile.lock /rnd_fashion_store_backend/Gemfile.lock
RUN gem install bundler -v 2.1.1
RUN bundle install
COPY . /rnd_fashion_store_backend

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]