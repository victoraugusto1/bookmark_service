# frozen_string_literal: true

json.extract! bookmark, :id, :title, :url, :shortened_url, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)
