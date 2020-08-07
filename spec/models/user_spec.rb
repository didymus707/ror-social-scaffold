require 'rails_helper'

RSpec.describe User, type: :model do
  let(:u1) do
    User.create(id: 1, name: 'Jane Doe', email: 'jd@email.com',
                password: '123456', gravatar_url: 'http://www.nil.com')
  end

  it 'is valid' do
    expect(u1).to be_valid
  end

  it 'is not valid without a name' do
    u1.name = nil
    expect(u1).to_not be_valid
  end

  it 'is valid with a name less than 20' do
    u1.name = 'a' * 19
    expect(u1).to be_valid
  end

  it 'is not valid with a name longer than 20' do
    u1.name = 'a' * 21
    expect(u1).to_not be_valid
  end

  it 'is invalid without an email' do
    u1.email = nil
    expect(u1).to_not be_valid
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:inverted_friendships) }
  end
end
