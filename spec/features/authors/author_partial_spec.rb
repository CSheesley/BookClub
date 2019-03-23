require 'rails_helper'

RSpec.describe 'author partial render', type: :view do
  it 'should render the view of an author with a link to author show page' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    author_2 = Author.create(name: "William Peterson")
    author_3 = Author.create(name: "Corey Sheesley")

    render author_1

    expect(response).to have_xpath("//div[@id='author-#{author_1.id}']")
    within "#author-#{author_1.id}" do
      expect(response).to have_content(author_1.name)
    end
    click_link author_1.name

    expect(current_path).to eq(author_path(author_1))
  end

end
