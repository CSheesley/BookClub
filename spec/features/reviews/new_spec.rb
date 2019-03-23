require 'rails_helper'

RSpec.describe 'new review workflow', type: :feature do
  context 'as a user visiting a books show page' do
    it 'shows a link to add a new review for the book' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

      visit book_path(book_1)

      click_link 'New Review'

      expect(current_path).to eq(new_book_review_path(book_1))

      expect(page).to have_content("Title")
      expect(page).to have_content("User")
      expect(page).to have_content("Rating")
      expect(page).to have_content("Text")
    end
  end

  context 'as a user filling out a new review form' do
    it 'should accept input for a new review of a book, including title, user, rating, text - and redirect to book show page and has new review content' do
      book_1 = Book.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

      visit new_book_review_path(book_1)

      review_title = "Best Ever"
      review_user = "User_1"
      review_rating = 5
      review_text = "Here is a long description of the review for the book"

      fill_in 'review[title]', with: review_title
      fill_in 'review[user]', with: review_user
      fill_in 'review[rating]', with: review_rating
      fill_in 'review[text]', with: review_text

      click_button 'Create Review'

      review = Review.last

      expect(current_path).to eq(book_path(book_1))
      expect(review.title).to eq(review_title)
      expect(review.text).to eq(review_text)
    end
  end
end
