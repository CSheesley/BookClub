require 'rails_helper'

RSpec.describe 'author partial render', type: :view do
  it 'should render the view of an author with a link to author show page' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    author_2 = Author.create(name: "William Peterson")
    author_3 = Author.create(name: "Corey Sheesley")

    render author_1

    expect(rendered).to have_selector("div", id:"author-#{author_1.id}")
    expect(rendered).to have_xpath("//a[@href='#{author_path(author_1)}']")
    expect(rendered).to have_selector("a", text:author_1.name)

    render author_2

    expect(rendered).to have_selector("div", id:"author-#{author_2.id}")
    expect(rendered).to have_xpath("//a[@href='#{author_path(author_2)}']")
    expect(rendered).to have_selector("a", text:author_2.name)

    render author_3

    expect(rendered).to have_selector("div", id:"author-#{author_3.id}")
    expect(rendered).to have_xpath("//a[@href='#{author_path(author_3)}']")
    expect(rendered).to have_selector("a", text:author_3.name)
  
  end
end
