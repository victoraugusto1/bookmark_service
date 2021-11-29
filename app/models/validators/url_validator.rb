require 'uri'

class UrlValidator < ActiveModel::Validator
    def validate(record)
        uri = URI.parse(record.url)
        if !uri.is_a?(URI::HTTP) || uri.host.nil?
            record.errors.add :base, "URL is invalid"
        end

        if record.shortened_url.present?
            shortened_uri = URI.parse(record.shortened_url)

            if !shortened_uri.is_a?(URI::HTTP) || shortened_uri.host.nil?
                record.errors.add :base, "Shortened URL is invalid"
            end    
        end
    rescue URI::InvalidURIError
        record.errors.add :base, "URL is invalid"
    end 
end