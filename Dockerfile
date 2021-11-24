FROM ruby:alpine
RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata
WORKDIR /bookmark_service
COPY Gemfile /bookmark_service/Gemfile
COPY Gemfile.lock /bookmark_service/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]