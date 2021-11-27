require './app/models/validators/url_validator.rb'

class Bookmark < ApplicationRecord
    validates :title, :url, presence: true
end
