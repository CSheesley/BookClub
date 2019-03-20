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

      within "#book-info" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Author(s): #{book_1.author_names.join(", ")}")
        expect(page).to have_content("Pages: #{book_1.pages}")
        expect(page).to have_content("Year of Publication: #{book_1.year}")
        expect(page).to have_xpath("//img[@src='#{book_1.cover}']")
      end

      within "#reviews" do
        within "#review-#{review_1.id}" do
          expect(page).to have_content(review_1.title)
          expect(page).to have_content(review_1.text)
          expect(page).to have_content(review_1.rating)
          expect(page).to have_content(review_1.user)
        end
      end

      visit book_path(book_2)

      within "#book-info" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Author(s): #{book_2.author_names.join(", ")}")
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Year of Publication: #{book_2.year}")
        expect(page).to have_xpath("//img[@src='#{book_2.cover}']")
      end

      within "#reviews" do
        within "#review-#{review_2.id}" do
          expect(page).to have_content(review_2.title)
          expect(page).to have_content(review_2.text)
          expect(page).to have_content(review_2.rating)
          expect(page).to have_content(review_2.user)
        end

        within "#review-#{review_3.id}" do
          expect(page).to have_content(review_3.title)
          expect(page).to have_content(review_3.text)
          expect(page).to have_content(review_3.rating)
          expect(page).to have_content(review_3.user)
        end
      end

    end
  end
end
