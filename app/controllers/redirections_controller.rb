class RedirectionsController < ApplicationController
    def redirect
        shortened_url = ENV["ROOT_URL"] + request.path.gsub("/", "")
        bookmark = Bookmark.find_by_shortened_url(shortened_url)
        if bookmark
            redirect_to bookmark.url
        else
            redirect_to bookmarks_path, flash: {alert: "Shortened URL not found"}
        end
    end
end