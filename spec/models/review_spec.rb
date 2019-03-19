require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :text}
    it { should validate_presence_of :user}
    it { should validate_presence_of :rating}
  end
end
