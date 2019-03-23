require 'rails_helper'

RSpec.describe 'review index page -- which is the user show page', type: :feature do
  it 'Only shows the reviews from the given user' do
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
  
    click_link "User_1"

    expect(current_path).to eq(reviews_path)
    expect(page).to have_content(review_1.user)
    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_2.title)
    expect(page).not_to have_content(review_3.title)

  end
end
