require 'rails_helper'

RSpec.describe 'book show page', type: :feature do
  context 'as a visitor' do
    it 'should show title, author(s), number of pages, year, and cover image' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = Book.create(title: "Title_1", pages: 200, year: 1999, cover: "madeupurl.com")
      book_1.author_ids = [author_1.id]

      book_2 = Book.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.author_ids = [author_2.id, author_3.id]
      #
      # book_author_1 = BookAuthor.create(book_id: book_1, author_id: author_1)
      # book_author_2 = BookAuthor.create(book_id: book_2, author_id: author_2)
      # book_author_3 = BookAuthor.create(book_id: book_2, author_id: author_3)

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")

      visit "/books/#{book_1.id}"
      # binding.pry
      within "#book-info" do
        expect(page).to have_content(book_1.title)
        ### NEEDS RE-WRITING
        # expect(page).to have_content("Author(s): #{book_1.authors.join(", ")}")
        expect(page).to have_content("Pages: #{book_1.pages}")
        expect(page).to have_content("Year of Publication: #{book_1.year}")
        expect(page).to have_xpath("//img[@src='#{book_1.cover}']")
      end

      within "#reviews" do
        within "#review_#{review_1.id}" do
          expect(page).to have_content(review_1.title)
          expect(page).to have_content(review_1.text)
          expect(page).to have_content(review_1.rating)
          expect(page).to have_content(review_1.user)
        end
      end

      visit "/books/#{book_2.id}"
      # save_and_open_page
      within "#book-info" do
        expect(page).to have_content(book_2.title)
        ### NEEDS RE-WRITING
        # expect(page).to have_content("Author(s): #{book_2.authors.join(", ")}")
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Year of Publication: #{book_2.year}")
        expect(page).to have_xpath("//img[@src='#{book_2.cover}']")
      end

      within "#reviews" do
        within "#review_#{review_2.id}" do
          expect(page).to have_content(review_2.title)
          expect(page).to have_content(review_2.text)
          expect(page).to have_content(review_2.rating)
          expect(page).to have_content(review_2.user)
        end

        within "#review_#{review_3.id}" do
          expect(page).to have_content(review_3.title)
          expect(page).to have_content(review_3.text)
          expect(page).to have_content(review_3.rating)
          expect(page).to have_content(review_3.user)
        end
      end

    end
  end
end
