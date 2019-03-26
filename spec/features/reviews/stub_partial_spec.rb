require 'rails_helper'

RSpec.describe 'review partial stub render', type: :view do
  it 'Should render the limited view of a review' do

    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render 'application/review_stub', review: review_1

    expect(rendered).to have_selector('div', id: "review-stub-#{review_1.id}")
    expect(rendered).to have_selector("div", id: "title", text: review_1.title)
    expect(rendered).to have_selector("div", id: "rating", text: review_1.rating)

    expect(rendered).to have_selector("div", id: "user-#{review_1.user}", text: review_1.user)
    expect(rendered).not_to have_content(review_1.text)
  end
end
