require 'rails_helper'

feature 'User vists homepage' do
  # background do
  #   User.create(email: 'jd@email.com', password: '123456')
  # end
  scenario 'succesfully' do
    sign_up('Jane Doe', 'jd@email.com', '123456')

    expect(page).to have_content 'Sign out'
  end
end
