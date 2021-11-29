# frozen_string_literal: true

require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  setup do
    Bookmark.destroy_all
  end

  test 'should create bookmark with title and URL' do
    bookmark = Bookmark.new(
      title: 'Bookmark title',
      url: 'https://bookmark.com'
    )

    assert bookmark.save
  end

  test 'should create bookmark with title, URL and shortened URL' do
    bookmark = Bookmark.new(
      title: 'Bookmark title',
      url: 'https://bookmark.com',
      shortened_url: 'https://shortened.com'
    )

    assert bookmark.save
  end

  test 'should generate shortened URL after saving bookmark' do
    bookmark = Bookmark.new(
      title: 'Bookmark title',
      url: 'https://bookmark.com'
    )
    bookmark.save

    assert_not_empty(bookmark.shortened_url)
  end

  test 'should not create bookmark without title' do
    bookmark = Bookmark.new(url: 'https://bookmark.com')

    assert_not bookmark.save
  end

  test 'should not create bookmark without URL' do
    bookmark = Bookmark.new(title: 'Bookmark title')

    assert_not bookmark.save
  end

  test 'should not create bookmark with invalid URL' do
    bookmark = Bookmark.new(
      title: 'Bookmark title',
      url: 'invalid url'
    )

    assert_not bookmark.save
  end

  test 'should not create bookmark with invalid shortened URL' do
    bookmark = Bookmark.new(
      title: 'Bookmark title',
      url: 'http://google.com',
      shortened_url: 'invalid url'
    )

    assert_not bookmark.save
  end

  test 'should add new bookmark with top level url' do
    Bookmark.new(
      title: 'Bookmark title',
      url: 'http://google.com/my_url'
    ).save

    top_level_bookmark = Bookmark.find_by_url('https://google.com')
    assert top_level_bookmark, nil
  end
end
