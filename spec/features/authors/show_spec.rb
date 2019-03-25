require 'rails_helper'

RSpec.describe 'author show page', type: :feature do
  context 'as a visitor' do
    it 'should show each of the authors books - its title, publication year, page count, and any other authors' do

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

      visit author_path(author_2)

      expect(page).to have_xpath("//section[@id='author']")

      within "#author" do
        expect(page).to have_content(author_2.name)
      end

      expect(page).to have_xpath("//div[@id='book-card-#{book_2.id}']")
      expect(page).to have_xpath("//div[@id='book-card-#{book_3.id}']")

      expect(page).not_to have_selector("div", id:"author-#{author_2.id}")

    end

    it 'should show top review for each book - if it has one' do

      author_1 = Author.create(name: "J.R.R Tolkein")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_1.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_1.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_2 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
      review_3 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")
      visit author_path(author_1)

      save_and_open_page
      expect(page).to have_selector('div', id:'book-pair-1')
      within "#book-pair-1" do
        expect(page).not_to have_selector('div', id: /review-/)
        expect(page).to have_selector('div', id:"book-card-#{book_1.id}")
      end

      expect(page).to have_selector('div', id:'book-pair-2')
      within "#book-pair-2" do
        expect(page).to have_selector('div', id:"review-#{review_1.id}")
        expect(page).to have_selector('div', id:"book-card-#{book_2.id}")
      end


      expect(page).to have_selector('div', id:'book-pair-3')
      within "#book-pair-3" do
        expect(page).to have_selector('div', id:"review-#{review_3.id}")
        expect(page).to have_selector('div', id:"book-card-#{book_3.id}")
      end

    end
  end
end
