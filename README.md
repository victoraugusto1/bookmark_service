# Bookmark Service

The purpose of this application is to manage bookmarks. You can create a bookmark with a title and a URL, and after saving it the application will generate a shortened URL that redirects you to the URL saved in your bookmark.

## About the architecture 

The project was made using Ruby 3.0.3, Rails 6.1.4.1, Bootstrap 5 and Webpacker

Most of the business rules are stored in the bookmarks model, with a special attention to URLs. Those are validated and shortened URLs are generated after saving a bookmark. 

The search feature works on top of searchkick, a gem that makes life easier when it comes to using Elasticsearch. Both created and updated bookmarks are automatically index in ES as well. This was done both to avoid using the main data source for searching and also because ES is great for text searching.

For testing we're using Capybara with RSpec for acceptance testing and Minitest for unit testing. 

## Running the application

This application was aimed to be run using Docker and Docker Compose. 

First thing to do is to build everything by running:

`docker-compose build`

After that, install Webpacker:

`docker-compose run --rm bookmark_service rails webpacker:install`

Create the database:

`docker-compose run --rm bookmark_service rails db:create`

And run the migrations:

`docker-compose run --rm bookmark_service rails db:migrate`

In case of unsufficient permissions messages, check Docker permissions or run Docker Compose with sudo.

## Running tests

Acceptance tests can be run using:

`docker-compose run --rm bookmark_service rails spec`

While unit tests can be run using:

`docker-compose run --rm bookmark_service rails test`

## Improvements and TODOS

There's a lot of space for improvements:
- The current compose file is aimed for development only and is not suitable for production. 
- The redirection feature doesn't contain unit nor acceptance tests
- A bookmark tag feature is missing
- All flash messages are being rendered as alerts
