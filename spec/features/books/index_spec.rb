require 'rails_helper'

RSpec.describe "book index page", type: :feature do
  context 'as a visitor' do
    context 'when I visit the book index page' do
      it 'each book entry shows all book card' do
        author_1 = Author.create(name: "J.R.R Tolkein")
        author_2 = Author.create(name: "William Peterson")

        book_1 = author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://differentmadeupurl.com')
        book_2 = author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://madeupurl.com')

        visit books_path

        expect(page).to have_selector('div', id:"book-card-#{book_1.id}")
        expect(page).to have_selector('div', id:"book-card-#{book_2.id}")
      end
    end
  end
end

    # xit 'shows the average rating next to each book title' do
    #   author_1 = Author.create(name: "J.R.R Tolkein")
    #   author_2 = Author.create(name: "William Peterson")
    #   author_3 = Author.create(name: "Corey Sheesley")
    #   # in author migration add (book_id:)
    #
    #   author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
    #   author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #   author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #   # in books migration add (author_id: , review_id: )
    #
    #   #add some reviews, linked to book objects
    #
    #   visit '/books'
    #
    #   within "#book-#{book_1.id}" do
    #     expect(page).to have_content("Average Rating: #{book_1.avg_rating}")
    #     expect(page).to have_content("Total Reviews: #{book_1.reviews.count}")
    #   end
    #   within "#book-#{book_2.id}" do
    #     expect(page).to have_content("Average Rating: #{book_2.avg_rating}")
    #     expect(page).to have_content("Total Reviews: #{book_2.reviews.count}")
    #   end
    # end
    #
    # xit 'shows one sorting link each for average rating, pages, reviews - ascending and descending' do
    #   author_1 = Author.create(name: "J.R.R Tolkein")
    #   author_2 = Author.create(name: "William Peterson")
    #   author_3 = Author.create(name: "Corey Sheesley")
    #
    #   author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
    #   author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #   author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #
    #   #best way to add reviews?
    #   book_1 = author_1.books.first
    #   book_2 = author_2.books.first
    #
    #   book_1.reviews.create(rating: 4, description: "Instant Classic.")
    #   book_1.reviews.create(rating: 5, description: "What an Adventure.")
    #   book_2.reviews.create(rating: 5, description: "A book by which all others are measured.")
    #
    #   visit '/books'
    #
    #   within "#sorting" do
    #     expect(page).to have_content("Average Rating: Ascending")
    #     expect(page).to have_content("Average Rating: Descending")
    #     expect(page).to have_content("Number of Pages: Ascending")
    #     expect(page).to have_content("Number of Pages: Descending")
    #     expect(page).to have_content("Number of Reviews: Ascending")
    #     expect(page).to have_content("Number of Reviews: Descending")
    #   end
    # end
    #
    # xit 'shows the three best and three worst books by review ranking (book title and rating score), and three users with the most reviews (user name and review count)' do
    #   author_1 = Author.create(name: "J.R.R Tolkein")
    #   author_2 = Author.create(name: "William Peterson")
    #   author_3 = Author.create(name: "Corey Sheesley")
    #
    #   author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
    #   author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #   author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
    #
    #   #best way to add reviews?
    #   book_1 = author_1.books.first
    #   book_2 = author_2.books.first
    #
    #   book_1.reviews.create(rating: 4, description: "Instant Classic.")
    #   book_1.reviews.create(rating: 5, description: "What an Adventure.")
    #   book_2.reviews.create(rating: 5, description: "A book by which all others are measured.")
    #
    #   visit '/books'
    #
    #   within "#sorting" do
    #     expect(page).to have_content("Average Rating: Ascending")
    #     expect(page).to have_content("Average Rating: Descending")
    #     expect(page).to have_content("Number of Pages: Ascending")
    #     expect(page).to have_content("Number of Pages: Descending")
    #     expect(page).to have_content("Number of Reviews: Ascending")
    #     expect(page).to have_content("Number of Reviews: Descending")
    #   end
    # end
