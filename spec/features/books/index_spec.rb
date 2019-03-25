require 'rails_helper'

RSpec.describe "book index page", type: :feature do
  before :each do
    @author_1 = Author.create(name: "J.R.R Tolkein")
    @author_2 = Author.create(name: "William Peterson")
    @author_3 = Author.create(name: "Corey Sheesley")

    @book_1 = @author_1.books.create(title: "The Best Book", pages: 310, year: 1937, cover: 'http://differentmadeupurl.com')
    @book_2 = @author_2.books.create(title: "The Average Book", pages: 150, year: 2018, cover: 'http://madeupurl.com')
    @book_3 = @author_3.books.create(title: "The Worst Book", pages: 550, year: 2018, cover: 'http://madeupurl.com')

    @review_1 = @book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
    @review_2 = @book_1.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
    @review_3 = @book_1.reviews.create(title: "If you have too" , text: "Meh", rating: 5, user: "User_2")
    @review_4 = @book_1.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")
    @review_5 = @book_1.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

    @review_6 = @book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
    @review_7= @book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 4, user: "User_2")
    @review_8 = @book_2.reviews.create(title: "Data Pro" , text: "What a list!", rating: 4, user: "User_2")
    @review_9 = @book_2.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

    @review_10 = @book_3.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 3, user: "User_1")
    @review_11 = @book_3.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
    @review_12 = @book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 3, user: "User_2")
  end

  context 'as a visitor' do
    context 'when I visit the book index page' do
      it 'each book entry shows all book card' do

        visit books_path

        expect(page).to have_selector('div', id:"book-card-#{@book_1.id}")
        expect(page).to have_selector('div', id:"book-card-#{@book_2.id}")
      end

      it 'should show links to sort books by (average rating, number of pages, and reviews)' do

        visit books_path

        within '#rating-sort' do
          expect(page).to have_link('Best Rated')
          expect(page).to have_link('Worst Rated')
        end
        within '#page-sort' do
          expect(page).to have_link('Most Pages')
          expect(page).to have_link('Fewest Pages')
        end
        within '#review-sort' do
          expect(page).to have_link('Most Reviews')
          expect(page).to have_link('Fewest Reviews')
        end
      end
    end

    context 'when I select a sort option' do
      it 'should sort the books based on average ratings - best and worst' do

        visit books_path

        click_link'Best Rated'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_1.id.to_s)
        expect(divs[1]).to eq(@book_2.id.to_s)
        expect(divs[2]).to eq(@book_3.id.to_s)

        click_link'Worst Rated'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_3.id.to_s)
        expect(divs[1]).to eq(@book_2.id.to_s)
        expect(divs[2]).to eq(@book_1.id.to_s)
      end

      it 'should sort the books based on number of pages - most and fewest' do

        visit books_path

        click_link'Most Pages'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_3.id.to_s)
        expect(divs[1]).to eq(@book_1.id.to_s)
        expect(divs[2]).to eq(@book_2.id.to_s)

        click_link'Fewest Pages'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_2.id.to_s)
        expect(divs[1]).to eq(@book_1.id.to_s)
        expect(divs[2]).to eq(@book_3.id.to_s)
      end

      it 'should sort the books based on number of reviews - most and fewest' do

        visit books_path

        click_link'Most Reviews'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_1.id.to_s)
        expect(divs[1]).to eq(@book_2.id.to_s)
        expect(divs[2]).to eq(@book_3.id.to_s)

        click_link'Fewest Reviews'
        divs = page.all('div')
        divs = divs.select{ |div| div[:id][0..9] == 'book-card-'}.map{|div| div[:id][10..-1]}

        expect(divs[0]).to eq(@book_3.id.to_s)
        expect(divs[1]).to eq(@book_2.id.to_s)
        expect(divs[2]).to eq(@book_1.id.to_s)
      end
    end

    context 'when I visit the book index page' do
      it 'should have book titles as links to that books own show page' do

        visit books_path

        within "#book-card-#{@book_1.id}" do
          expect(page).to have_link("#{@book_1.title}")
          click_link @book_1.title
          expect(current_path).to eq(book_path(@book_1))
        end

        visit books_path

        within "#book-card-#{@book_2.id}" do
          expect(page).to have_link("#{@book_2.title}")
          click_link @book_2.title
          expect(current_path).to eq(book_path(@book_2))
        end

        visit books_path

        within "#book-card-#{@book_3.id}" do
          expect(page).to have_link("#{@book_3.title}")
          click_link @book_3.title
          expect(current_path).to eq(book_path(@book_3))
        end
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

    # end
