# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bookmark searching', type: :feature do
  before(:each) do
    Bookmark.destroy_all
  end

  it 'should find bookmark by title' do
    Bookmark.new(
      title: 'Google bookmark', url: 'http://bookmark.com'
    ).save!

    Bookmark.searchkick_index.refresh

    visit '/'

    fill_in 'Search', with: 'google'
    click_button 'Search'

    expect(page).to have_content 'Google bookmark'
  end

  it 'should find bookmark by url' do
    Bookmark.new(
      title: 'Random bookmark', url: 'http://reddit.com'
    ).save!

    Bookmark.searchkick_index.refresh

    visit '/'

    fill_in 'Search', with: 'reddit'
    click_button 'Search'

    expect(page).to have_content 'http://reddit.com'
  end

  it 'should find bookmark by shortened url' do
    Bookmark.new(
      title: 'Another bookmark',
      url: 'http://facebook.com',
      shortened_url: 'http://fb.com'
    ).save!

    Bookmark.searchkick_index.refresh

    visit '/'

    fill_in 'Search', with: 'fb'
    click_button 'Search'

    expect(page).to have_content 'http://fb.com'
  end

  it 'should show more than one result when possible' do
    Bookmark.new(
      title: 'Google bookmark',
      url: 'http://something.com'
    ).save!

    Bookmark.new(
      title: 'Another bookmark',
      url: 'http://google.com'
    ).save!

    Bookmark.new(
      title: 'Other bookmark',
      url: 'http://site.com',
      shortened_url: 'http://googlewebsite.com'
    ).save!

    Bookmark.searchkick_index.refresh

    visit '/'

    fill_in 'Search', with: 'google'
    click_button 'Search'

    expect(page).to have_content 'Google bookmark'
    expect(page).to have_content 'http://google.com'
    expect(page).to have_content 'http://googlewebsite.com'
  end
end
