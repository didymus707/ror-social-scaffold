require 'rails_helper'

feature 'User sees others posts' do
  background do
    User.create(name: 'Jane Doe', email: 'jd@email.com', password: '123456')
  end

  scenario 'successfully' do
    sign_in_with 'jd@email.com', '123456'

    expect(page).to have_content 'Recent posts'
  end
end
