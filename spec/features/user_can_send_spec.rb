require 'rails_helper'

feature 'Friendships: User can' do
  before :each do
    User.create(name: 'Jane Doe', email: 'jd@email.com', password: '123456')
    User.create(name: 'Joe Blow', email: 'joeblow@email.com', password: '123456')
  end

  scenario 'send requests successfully' do
    sign_in_with 'jd@email.com', '123456'
    click_on 'All users'
    click_link 'Add Friend'

    expect(page).to have_content 'Pending Requests'
    expect(page).to have_content 'Friend request sent!'
    expect(page).not_to have_link 'Add Friend'
  end

  scenario 'accept requests successfully' do
    fr1 = Friendship.new(user_id: User.first.id, friend_id: User.last.id, status: 'requested')
    fr1.save

    sign_in_with 'joeblow@email.com', '123456'
    click_on 'All users'
    click_link 'Accept'

    expect(page).to have_content 'Friend Request Accepted!'
    expect(page).to have_content 'My Friends'
  end

  scenario 'decline requests successfully' do
    fr1 = Friendship.new(user_id: User.first.id, friend_id: User.last.id, status: 'requested')
    fr1.save

    sign_in_with 'joeblow@email.com', '123456'
    click_on 'All users'
    click_link 'Decline'

    expect(page).to have_content 'Friend Request Declined!'
    expect(page).to have_content 'Add Friend'
  end
end
