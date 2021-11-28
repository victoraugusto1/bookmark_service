class Bookmark < ApplicationRecord
    searchkick

    validates :title, :url, presence: true

    before_save :generate_shortened_url

    private

    def generate_shortened_url 
        if shortened_url.blank?
            root_url = ENV["ROOT_URL"]
            shortened_url_suffix = SecureRandom.urlsafe_base64(6)
            self.shortened_url = root_url + shortened_url_suffix
        end
    end
end
