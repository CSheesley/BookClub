require 'rails_helper'

Rspec.describe "book index page", type: :feature do
  context 'as a visitor' do
    context 'when I visit the book index page' do
      it 'shows a list of all book titles in the database' do
        author_1 = Author.create(name: "J.R.R Tolkein")
        author_2 = Author.create(name: "William Peterson")
        author_3 = Author.create(name: "Corey Sheesley")
        # in author migration add (book_id:)

        author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
        author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://madeupurl.com')
        author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://madeupurl.com')
        # in books migration add (author_id: , review_id: )

        visit '/books'

        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Author(s): #{book_1.authors.name}")
        expect(page).to have_content("Pages: #{book_1.pages}")
        expect(page).to have_content("Published: #{book_1.year}")

        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Author(s): #{book_2.authors.name}")
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Published: #{book_2.year}")
      end
    end

    xit 'shows the average rating next to each book title' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")
      # in author migration add (book_id:)

      author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
      author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
      author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
      # in books migration add (author_id: , review_id: )

      #add some reviews, linked to book objects

      visit '/books'

      within "#book-#{book_1.id}" do
        expect(page).to have_content("Average Rating: #{book_1.avg_rating}")
        expect(page).to have_content("Total Reviews: #{book_1.reviews.count}")
      end
      within "#book-#{book_2.id}" do
        expect(page).to have_content("Average Rating: #{book_2.avg_rating}")
        expect(page).to have_content("Total Reviews: #{book_2.reviews.count}")
      end
    end

    xit 'shows one sorting link each for average rating, pages, reviews - ascending and descending' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
      author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
      author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')

      #best way to add reviews?
      book_1 = author_1.books.first
      book_2 = author_2.books.first

      book_1.reviews.create(rating: 4, description: "Instant Classic.")
      book_1.reviews.create(rating: 5, description: "What an Adventure.")
      book_2.reviews.create(rating: 5, description: "A book by which all others are measured.")

      visit '/books'

      within "#sorting" do
        expect(page).to have_content("Average Rating: Ascending")
        expect(page).to have_content("Average Rating: Descending")
        expect(page).to have_content("Number of Pages: Ascending")
        expect(page).to have_content("Number of Pages: Descending")
        expect(page).to have_content("Number of Reviews: Ascending")
        expect(page).to have_content("Number of Reviews: Descending")
      end
    end

    xit 'shows the three best and three worst books by review ranking (book title and rating score), and three users with the most reviews (user name and review count)' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      author_1.books.create(title: "The Hobbit", pages: 310, year: 1937, cover: 'http://madeupurl.com')
      author_2.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')
      author_3.books.create(title: "Best Website Ever", pages: 100, year: 2018, cover: 'http://othermadeupurl.com')

      #best way to add reviews?
      book_1 = author_1.books.first
      book_2 = author_2.books.first

      book_1.reviews.create(rating: 4, description: "Instant Classic.")
      book_1.reviews.create(rating: 5, description: "What an Adventure.")
      book_2.reviews.create(rating: 5, description: "A book by which all others are measured.")

      visit '/books'

      within "#sorting" do
        expect(page).to have_content("Average Rating: Ascending")
        expect(page).to have_content("Average Rating: Descending")
        expect(page).to have_content("Number of Pages: Ascending")
        expect(page).to have_content("Number of Pages: Descending")
        expect(page).to have_content("Number of Reviews: Ascending")
        expect(page).to have_content("Number of Reviews: Descending")
      end
    end

  end
end
