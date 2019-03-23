require 'rails_helper'

RSpec.describe 'review partial render', type: :view do
  it 'Should render the view of a review' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render review_1

    expect(rendered).to have_selector('div', id: "review-#{review_1.id}")
    expect(rendered).to have_selector("div", id: "title", text: review_1.title)
    expect(rendered).to have_selector("div", id: "text", text: review_1.text)
    expect(rendered).to have_selector("div", id: "rating", text: review_1.rating)
    expect(rendered).to have_selector("div", id: "user", text: review_1.user)
    expect(rendered).to have_link(review_1.user, href:reviews_path(user: review_1.user))

  end

  it 'should not print the user name if it is on user show page, where show:true' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render review_1, show: true
  
    expect(rendered).to have_selector('div', id: "review-#{review_1.id}")
    expect(rendered).to have_selector("div", id: "title", text: review_1.title)
    expect(rendered).to have_selector("div", id: "text", text: review_1.text)
    expect(rendered).to have_selector("div", id: "rating", text: review_1.rating)
    expect(rendered).to_not have_selector("div", id: "user", text: review_1.user)
    expect(rendered).to have_link(review_1.user, href:reviews_path(user: review_1.user))

  end
end
