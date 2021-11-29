# frozen_string_literal: true

require 'uri'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    uri = URI.parse(record.url)

    record.errors.add :base, 'URL is invalid' if record.url.present? && uri.host.nil?

    if record.shortened_url.present?
      shortened_uri = URI.parse(record.shortened_url)
      record.errors.add :base, 'Shortened URL is invalid' if shortened_uri.host.nil?
    end
  rescue URI::InvalidURIError
    record.errors.add :base, 'URL is invalid'
  end
end
