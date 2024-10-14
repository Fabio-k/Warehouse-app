require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#describe' do
    it 'show name and email' do
      user = User.create!(name: 'user', email: 'user@gmail.com', password: 'senha123')
      expect(user.description).to eq 'user - user@gmail.com'
    end
  end
end
