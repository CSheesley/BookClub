require 'rails_helper'

RSpec.describe 'book show page', type: :feature do
  context 'as a visitor' do
    it 'should show title, author(s), number of pages, year, and cover image' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = Book.create(title: "Title_1", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = Book.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")

      book_author_1 = BookAuthor.create(book_id: book_1, author_id: author_1)
      book_author_2 = BookAuthor.create(book_id: book_2, author_id: author_2)
      book_author_3 = BookAuthor.create(book_id: book_2, author_id: author_3)

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")

      visit "/books/#{book_1.id}"

      within "#book-info" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Author(s): #{book_1.authors.join(", ")}")
        expect(page).to have_content("Pages: #{book_1.pages}")
        expect(page).to have_content("Year of Publication: #{book_1.year}")
        expect(page).to have_xpath("//img[@src='#{book_1.cover}']")
      end

      within "#reviews" do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.text)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.user)
      end
    end
  end
end
