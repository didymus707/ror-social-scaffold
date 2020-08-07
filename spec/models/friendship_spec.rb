require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:f) do
    User.create(id: 1, name: 'Jane Doe', email: 'jd@email.com',
                password: '123456', gravatar_url: 'http://www.nil.com')
    User.create(id: 2, name: 'Joe Blow', email: 'jb@email.com',
                password: '123456', gravatar_url: 'http://www.nil.com')
    Friendship.new(user_id: 1, friend_id: 2, status: 'requested')
  end

  it 'is valid' do
    expect(f).to be_valid
  end

  it 'is not valid without a sender/receiver' do
    f.friend_id = nil
    expect(f).to_not be_valid
  end

  it 'is invalid without a status' do
    f.status = nil
    expect(f).to_not be_valid
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
    it { should validate_presence_of(:status) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
