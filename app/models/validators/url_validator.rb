require 'uri'
require "pry"

class UrlValidator < ActiveModel::Validator
    def validate(record)
        uri = URI.parse(record.url)

        if record.url.present? && uri.host.nil?
            record.errors.add :base, "URL is invalid"
        end

        if record.shortened_url.present?
            shortened_uri =  URI.parse(record.shortened_url)
            if shortened_uri.host.nil?
                record.errors.add :base, "Shortened URL is invalid"
            end
        end

    rescue URI::InvalidURIError
        record.errors.add :base, "URL is invalid"
    end
end