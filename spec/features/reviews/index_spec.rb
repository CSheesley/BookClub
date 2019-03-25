require 'rails_helper'

RSpec.describe 'review index page -- which is the user show page', type: :feature do
  before :each do
    @author_1 = Author.create(name: "J.R.R Tolkein")
    @author_2 = Author.create(name: "William Peterson")
    @author_3 = Author.create(name: "Corey Sheesley")

    @book_1 = @author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    @book_2 = @author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
    @book_2.authors << @author_3
    @book_3 = @author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

    @review_1 = @book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
    @review_2 = @book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
    @review_3 = @book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")
    @review_4 = @book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 5, user: "User_2")

  end
  it 'Only shows the reviews from the given user' do

    visit book_path(@book_1)

    click_link "User_1"

    expect(current_path).to eq(reviews_path)
    expect(page).to have_selector('div', id: "review-#{@review_1.id}")
    expect(page).to have_selector('div', id: "review-#{@review_2.id}")
    expect(page).not_to have_selector('div', id: "review-#{@review_3.id}")
  end

  it 'Shows books associated with the review' do

    visit reviews_path(user: "User_1")
    expect(page).to have_selector('div', id: 'review-pair-1')
    within "#review-pair-1" do
      expect(page).to have_selector('div', id: "review-#{@review_1.id}")
      expect(page).to have_selector('div', id: "book-card-#{@book_1.id}")
    end

    expect(page).to have_selector('div', id: 'review-pair-2')
    within "#review-pair-2" do
      expect(page).to have_selector('div', id: "review-#{@review_2.id}")
      expect(page).to have_selector('div', id: "book-card-#{@book_2.id}")
    end

    expect(page).not_to have_selector('div', id: 'review-pair-3')
    expect(page).not_to have_selector('div', id: "book-card-#{@book_3.id}")

  end

  it 'has links for sorting, that send to ordered page' do
    visit reviews_path(user: "User_1")

    click_link "Oldest First"

    divs = page.all('div')
    divs = divs.select do |div|
      (div[:id].split("-")[0] == 'review') & (div[:id].split("-").length == 2)
    end.map{|div| div[:id].split("-")[1]}

    expect(divs[0]).to eq(@review_1.id.to_s)
    expect(divs[1]).to eq(@review_2.id.to_s)

    click_link "Newest First"

    divs = page.all('div')
    divs = divs.select do |div|
      (div[:id].split("-")[0] == 'review') & (div[:id].split("-").length == 2)
    end.map{|div| div[:id].split("-")[1]}

    expect(divs[0]).to eq(@review_2.id.to_s)
    expect(divs[1]).to eq(@review_1.id.to_s)
  end

  it 'deletes a review when the delete button is pressed' do
    visit reviews_path(user: "User_1")
    within '#review-pair-1' do
      click_link "Delete"
    end
    expect(Review.all.count).to eq(3)
    expect(page).not_to have_selector('div', id: "review-#{@review_1.id}")
    expect(page).to have_content("User_1")
  end

end
