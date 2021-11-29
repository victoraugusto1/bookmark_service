require "rails_helper"

RSpec.describe "bookmark management", type: :feature do
    context "creating a bookmark" do
        before(:each) do
            Bookmark.destroy_all
        end

        context "valid bookmark" do
            it "creates bookmark with title and url" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Url", with: "http://bookmark.com"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "Bookmark was successfully created."
    
                click_on("Back")
    
                expect(page).to have_content "Bookmark title"
                expect(page).to have_content "http://bookmark.com"
            end
    
            it "creates bookmark with title, url and shortened url" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Url", with: "http://bookmark.com"
                fill_in "Shortened url", with: "http://shortened.com"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "Bookmark was successfully created."
    
                click_on("Back")
    
                expect(page).to have_content "Bookmark title"
                expect(page).to have_content "http://bookmark.com"
            end

            it "should generate a shortened url" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Url", with: "http://bookmark.com"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "Bookmark was successfully created."
    
                click_on("Back")
    
                expect(page).to have_content "localhost:3000"
            end            
        end

        context "invalid bookmark" do
            it "does not create bookmark without title" do
                visit "bookmarks/new"
                
                fill_in "Url", with: "http://bookmark.com"
                fill_in "Shortened url", with: "http://shortened.com"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "Title can't be blank"
    
                click_on("Back")
    
                expect(page).not_to have_content "Bookmark title"
                expect(page).not_to have_content "http://bookmark.com"
            end
    
            it "does not create bookmark without url" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Shortened url", with: "http://shortened.com"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "Url can't be blank"
    
                click_on("Back")
    
                expect(page).not_to have_content "Bookmark title"
                expect(page).not_to have_content "http://bookmark.com"
            end

            it "does not create a bookmark with an invalid URL" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Url", with: "invalid url"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "URL is invalid"
    
                click_on("Back")
    
                expect(page).not_to have_content "Bookmark title"
                expect(page).not_to have_content "http://bookmark.com"                
            end

            it "does not create a bookmark with an invalid URL" do
                visit "bookmarks/new"
                
                fill_in "Title", with: "Bookmark title"
                fill_in "Url", with: "http://bookmark.com"
                fill_in "Shortened url", with: "invalid url"
    
                click_button "Create bookmark"
    
                expect(page).to have_content "URL is invalid"
    
                click_on("Back")
    
                expect(page).not_to have_content "Bookmark title"
                expect(page).not_to have_content "http://bookmark.com"                
            end
        end
    end

    context "editing bookmarks" do
        before(:each) do
            Bookmark.destroy_all
        end

        context "valid edit" do
            it "should update title" do
                Bookmark.new(title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Title", with: "New title"
                click_button "Update bookmark"
    
                expect(page).to have_content "Bookmark was successfully updated."
    
                click_on("Back")
    
                expect(page).to have_content "New title"
            end
    
            it "should update url" do
                Bookmark.new(title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Url", with: "http://new.com"
                click_button "Update bookmark"
    
                expect(page).to have_content "Bookmark was successfully updated."
    
                click_on("Back")
    
                expect(page).to have_content "http://new.com"
            end
    
            it "should add shortened url" do
                Bookmark.new(title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Shortened url", with: "http://shortened.com"
                click_button "Update bookmark"
    
                expect(page).to have_content "Bookmark was successfully updated."
    
                click_on("Back")
    
                expect(page).to have_content "http://shortened.com"
            end
    
            it "should remove shortened url" do
                Bookmark.new(
                    title: "Bookmark title", 
                    url: "http://bookmark.com", 
                    shortened_url: "http://shortened.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Shortened url", with: ""
                click_button "Update bookmark"
    
                expect(page).to have_content "Bookmark was successfully updated."
    
                click_on("Back")
    
                expect(page).not_to have_content "http://shortened.com"
            end
        end

        context "invalid edit" do
            it "should not allow user to remove title" do
                Bookmark.new(
                    title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Title", with: ""
                click_button "Update bookmark"
    
                expect(page).to have_content "Title can't be blank"
            end
    
            it "should not allow user to remove url" do
                Bookmark.new(
                    title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Url", with: ""
                click_button "Update bookmark"
    
                expect(page).to have_content "Url can't be blank"
            end

            it "should not update url to an invalid one" do
                Bookmark.new(
                    title: "Bookmark title", url: "http://bookmark.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Url", with: "invalid"
                click_button "Update bookmark"
    
                expect(page).to have_content "URL is invalid"
            end

            it "should not update shortened url to an invalid one" do
                Bookmark.new(
                    title: "Bookmark title", 
                    url: "http://bookmark.com", 
                    shortened_url: "http://shortened.com").save!
    
                visit "/bookmarks"
    
                click_on("Edit")
                fill_in "Shortened url", with: "invalid"
                click_button "Update bookmark"
    
                expect(page).to have_content "URL is invalid"
            end
        end
    end
end