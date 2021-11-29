# frozen_string_literal: true

require 'validators/url_validator'

class Bookmark < ApplicationRecord
  searchkick word_middle: %i[title url shortened_url]

  before_validation :normalize_url

  validates :title, :url, presence: true
  validates_with UrlValidator

  before_save :generate_shortened_url

  after_save do
    url_path = URI.parse(url).path

    unless url_path.empty?
      host_bookmarks = Bookmark.search(url, fields: [url: :exact])

      if host_bookmarks.empty?
        new_url = "https://#{URI.parse(url).host}"
        new_bookmark_title = url.split('.')[0].split('//')[1]
        Bookmark.new(title: new_bookmark_title, url: new_url).save
      end
    end
  end

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
      root_url = ENV['ROOT_URL']
      shortened_url_suffix = SecureRandom.urlsafe_base64(6)
      self.shortened_url = root_url + shortened_url_suffix
    end
  end

  def normalize_url
    if url.present?
      scheme = URI.parse(url).scheme
      self.url = "https://#{url}" if scheme.nil?
    end
  rescue URI::InvalidURIError
    errors.add :base, 'URL is invalid'
  end
end
