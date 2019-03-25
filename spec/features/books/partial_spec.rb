require 'rails_helper'

RSpec.describe 'book partial render', type: :view do
  it 'Should render the all book information of a book with one author' do
    author_1 = Author.create(name: "J.R.R Tolkein")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1

    expect(rendered).to have_selector('div', id:"book-card-#{book_1.id}")
    expect(rendered).to have_selector('div', id:"book-title", text:book_1.title)
    expect(rendered).to have_selector('div', id:"book-pages", text:book_1.pages)
    expect(rendered).to have_selector('div', id:"book-year", text:book_1.year)
    expect(rendered).to have_selector('div', id:"book-cover")
    expect(rendered).to have_xpath("//img[@src='#{book_1.cover}']")
    expect(rendered).to have_selector('div', id:"author-#{author_1.id}")
    expect(rendered).to have_selector('div', id:"author-info", text: "By:")

  end

  it 'Should render the all book information of a book with two authors' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    author_2 = Author.create(name: "Corey Sheesley")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    book_1.authors << author_2

    render book_1

    expect(rendered).to have_selector('div', id:"book-card-#{book_1.id}")
    expect(rendered).to have_selector('div', id:"book-title", text:book_1.title)
    expect(rendered).to have_selector('div', id:"book-pages", text:book_1.pages)
    expect(rendered).to have_selector('div', id:"book-year", text:book_1.year)
    expect(rendered).to have_selector('div', id:"book-cover")
    expect(rendered).to have_xpath("//img[@src='#{book_1.cover}']")
    expect(rendered).to have_selector('div', id:"author-#{author_1.id}")
    expect(rendered).to have_selector('div', id:"author-#{author_2.id}")
    expect(rendered).to have_selector('div', id:"author-info", text: "By:")
  end

  it 'Should have a link to new review' do
    author_1 = Author.create(name: "J.R.R Tolkein")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1
    expect(rendered).to have_xpath("//a[@href='#{new_book_review_path(book_1)}']")
    expect(rendered).to have_selector('a', text: "New Review")

  end

  it 'Should print NO co-author information if there is only one author' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1, author: author_1

    expect(rendered).not_to have_selector('div', id:'author-info', text: "With:")
    expect(rendered).not_to have_selector('div', id:'author-info', text: "By:")

  end

  it 'Should print ONLY the co-author name when specified' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    author_2 = Author.create(name: "Corey Sheesley")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    book_1.authors << author_2

    render book_1, author: author_1
    expect(rendered).not_to have_selector('div', id:'author-info', text: "By:")
    expect(rendered).not_to have_selector('div', id:"author-#{author_1.id}")

    expect(rendered).to have_selector('div', id:'author-info', text: "With:")
    expect(rendered).to have_selector('div', id:"author-#{author_2.id}")

  end

  it 'Should Give Link To Book show page by default' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1

    expect(rendered).to have_link("#{book_1.title}", href:book_path(book_1))
  end

  it 'Should NOT give a link to the book if book_show_page == true' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1, book_show_page: true

    expect(rendered).not_to have_link("#{book_1.title}", href:book_path(book_1))
  end

  it 'should show the average rating and number of reviews next to each book' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1

    expect(rendered).to have_selector('div', id:'book-stats', text: "Average Rating: #{book_1.average_rating}")
    expect(rendered).to have_selector('div', id:'book-stats', text: "Total Reviews: #{book_1.total_reviews}")
  end
end
