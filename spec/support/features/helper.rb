module Features
  def sign_up(name, email, password)
    visit new_user_registration_path

    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_on 'Sign up'
  end

  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_on 'Log in'
  end
end
