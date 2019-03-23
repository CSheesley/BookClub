require 'rails_helper'

RSpec.describe 'new review workflow', type: :feature do
  context 'as a user visiting a books show page' do
    it 'shows a link to add a new review for the book' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

      visit book_path(book_1)

      click_link 'New Review'

      expect(current_path).to eq(new_review_path)

      expect(page).to have_content("Title")
      expect(page).to have_content("User")
      expect(page).to have_content("Rating")
      expect(page).to have_content("Text")
    end
  end
end
