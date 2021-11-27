require "test_helper"

class BookmarkTest < ActiveSupport::TestCase
  test "should create bookmark with title and URL" do
    bookmark = Bookmark.new(title: "Bookmark title", url: "https://bookmark.com")
    assert bookmark.save
  end

  test "should create bookmark with title, URL and shortened URL" do
    bookmark = Bookmark.new(
      title: "Bookmark title", url: "https://bookmark.com", shortened_url: "https://shortened.com")
    assert bookmark.save
  end

  test "should not create bookmark without title" do
    bookmark = Bookmark.new(url: "https://bookmark.com")
    assert_not bookmark.save
  end

  test "should not create bookmark without URL" do
    bookmark = Bookmark.new(title: "Bookmark title")
    assert_not bookmark.save
  end
end
