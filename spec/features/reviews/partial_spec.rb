require 'rails_helper'

RSpec.describe 'review partial render', type: :view do
  it 'Should render the view of a review' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render review_1
    # expect(response).to have_content("asldkhgas")
    expect(rendered).to have_selector('div', id: "review-#{review_1.id}")
    expect(rendered).to have_selector("div", id: "title", exact_text: review_1.title)

    # expect(rendered).to have_("//div[@id='review-#{review_1.id}']")
    # expect(rendered).to have_tag('div', :text=> review_1.title)
    # expect(response).to have_content(review_1.text)
    # expect(response).to have_content(review_1.rating)
    # expect(response).to_not have_content(review_1.user)

  end

  it 'should not print the user name if it is on user show page, where show:true' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render review_1, show: true

    expect(response).to have_xpath("//div[@id='review-#{review_1.id}']")
    within "#review-#{review_1.id}" do
      expect(response).to have_content(review_1.title)
      expect(response).to have_content(review_1.text)
      expect(response).to have_content(review_1.rating)
      expect(response).to_not have_content(review_1.user)
    end

  end
end
