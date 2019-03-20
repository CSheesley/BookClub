require 'rails_helper'

RSpec.describe 'author show page', type: :feature do
  context 'as a visitor' do
    it 'should show each of the authors books - its title, publication year, page count, and any other authors' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = Book.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = Book.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_3 = Book.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      book_author_1 = BookAuthor.create(book: book_1, author: author_1)
      book_author_2 = BookAuthor.create(book: book_2, author: author_2)
      book_author_3 = BookAuthor.create(book: book_2, author: author_3)
      book_author_4 = BookAuthor.create(book: book_3, author: author_2)

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

      visit "/authors/#{author_2.id}"

        expect(page).to have_content(author_2.books)

      within "#author-info" do
        expect(page).to have_content(author.name)
      end
      within "#books-#{book_2.id}" do
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Year of Publication: #{book_2.year}")
        # expect(page).to have_content("Co-Authors: #{book_2.co_authors}")
      end
      within "#books-#{book_3.id}" do
        expect(page).to have_content("Pages: #{book_3.pages}")
        expect(page).to have_content("Year of Publication: #{book_3.year}")
        # expect(page).to have_content("Co-Authors: #{book_3.co_authors}")
      end
    end
  end
end
