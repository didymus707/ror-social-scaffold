require 'rails_helper'

feature 'User signs in' do
  background do
    User.create(name: 'Jane Doe', email: 'jd@email.com', password: '123456')
  end

  scenario 'with valid email and password' do
    sign_in_with 'jd@email.com', '123456'

    expect(page).to have_content 'Sign out'
  end

  scenario 'with invalid email or password' do
    sign_in_with 'jd', '123456'

    expect(page).to have_content 'Invalid Email or password'
  end
end
