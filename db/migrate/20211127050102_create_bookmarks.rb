# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :url
      t.string :shortened_url

      t.timestamps
    end
  end
end
