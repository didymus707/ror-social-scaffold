require 'rails_helper'

feature "User vists homepage" do
  scenario "succesfully" do
    visit new_user_session_path

    click_on 'Sign up'

    fill_in 'Name', with: 'Jane Doe'
    fill_in 'Email', with: 'janedoe@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    expect(page).to have_content "Stay in touch"
  end
end