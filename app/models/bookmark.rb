class Bookmark < ApplicationRecord
    searchkick word_middle: [:title, :url, :shortened_url]

    validates :title, :url, presence: true

    before_save :generate_shortened_url

    def search_data
        {
          title: title,
          url: url,
          shortened_url: shortened_url
        }
    end

    private

    def generate_shortened_url 
        if shortened_url.blank?
            root_url = ENV["ROOT_URL"]
            shortened_url_suffix = SecureRandom.urlsafe_base64(6)
            self.shortened_url = root_url + shortened_url_suffix
        end
    end
end
