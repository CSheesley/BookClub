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

        # expect(page).to have_content(author_2.books)

        # expect(page).to have_xpath(//div[@id=book-card-#{book_2.id}])

        # Every "Book card" will be in a <div> tag WHERE id="book-card-#{:id}"

      within "#author-info" do
        expect(page).to have_content(author_2.name)
      end
      within "#books-#{book_2.id}" do
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Year of Publication: #{book_2.year}")
        expect(page).to have_content("Co-Authors: #{book_2.co_authors(author_2).join(", ")}")
      end
      within "#books-#{book_3.id}" do
        expect(page).to have_content("Pages: #{book_3.pages}")
        expect(page).to have_content("Year of Publication: #{book_3.year}")
        expect(page).to_not have_content("Co-Authors:")
      end
    end
  end
end
