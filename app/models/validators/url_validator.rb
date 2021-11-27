require 'uri'

class UrlValidator < ActiveModel::Validator
    def validate(record)
        uri = URI.parse(record.url)
        if !uri.is_a?(URI::HTTP) || uri.host.nil?
            record.errors.add :base, "URL is invalid"
        end
    rescue URI::InvalidURIError
        record.errors.add :base, "URL is invalid"
    end 
end