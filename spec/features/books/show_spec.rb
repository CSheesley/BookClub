require 'rails_helper'

RSpec.describe 'book show page', type: :feature do
  context 'as a visitor' do
    it 'should show title, author(s), number of pages, year, and cover image' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

      visit book_path(book_1)

      expect(page).to have_xpath("//section[@id='book-info']")
      within "#book-info" do
        expect(page).to have_xpath("//div[@id='book-card-#{book_1.id}']")
      end
      expect(page).to have_xpath("//section[@id='reviews']")
      within "#reviews" do
        expect(page).to have_xpath("//div[@id='review-#{review_1.id}']")
      end

      visit book_path(book_2)

      expect(page).to have_xpath("//section[@id='book-info']")
      within "#book-info" do
        expect(page).to have_xpath("//div[@id='book-card-#{book_2.id}']")
      end

      expect(page).to have_xpath("//section[@id='reviews']")
      within "#reviews" do
        expect(page).to have_xpath("//div[@id='review-#{review_2.id}']")
        expect(page).to have_xpath("//div[@id='review-#{review_3.id}']")
      end
    end

    it 'should not have the book title contain a link to the show page' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

      expect(page).not_to have_link("#{book_1.title}")
    end

    it 'should have a link to delete the book' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

      visit book_path(book_2)

      expect(page).to have_link("Delete", href:book_path(book_2))
      within "#book-info" do
        click_link "Delete"
      end


      expect(current_path).to eq(books_path)
      expect(Review.all.count).to eq(2)
      expect(Author.all.count).to eq(2)
      expect(Book.all.count).to eq(2)

      expect(page).not_to have_selector('div', id:"book-card-#{book_2.id}")

    end
  end
end
