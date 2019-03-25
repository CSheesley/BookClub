require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}

    it 'validates that name is uniqe' do
      author_1 = Author.create(name: "Dan Brown")
      author_2 = Author.create(name: "Dan Brown")

      expect(Author.count).to eq(1)
    end
  end

  describe 'Relationships' do
    it { should have_many :book_authors}
    it { should have_many(:books).through :book_authors }
  end

  describe 'Class Methods' do
    it '.authors_from_string creates list of authors' do
      author_string_1 = "Dan Brown"
      author_string_2 = "Dan Brown, corey sheesley"

      author_list_1 = Author.authors_from_string(author_string_1)
      author_list_2 = Author.authors_from_string(author_string_2)

      expect(author_list_1[0].name).to eq(author_string_1)
      expect(author_list_1.length).to eq(1)

      expect(author_list_2[0].name).to eq("Dan Brown")
      expect(author_list_2[1].name).to eq("Corey Sheesley")
      expect(author_list_2.length).to eq(2)
    end

    it '.authors_from_string does not try to create an author if name is blank after comma' do
      author_string = "Dan Brown, "

      author_list = Author.authors_from_string(author_string)

      expect(author_list[0].name).to eq("Dan Brown")
      expect(author_list.length).to eq(1)

    end
  end
end
