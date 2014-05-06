describe 'user registration' do
  # it 'clicking the signup link takes you to the signup form' do
  #   visit root_url
  #   click_link('Sign Up')
  #   expect(current_path).to eq(new_user_registration_path)
  # end

  it "stays on the sign in page if password is invalid" do
    visit '/users/sign_up'
    fill_in 'First name', with: 'Greg'
    fill_in 'Last name', with: 'Heaphy'
    fill_in 'Email', with: 'Heaphy@heaphy.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'passwordWRONG'
    expect { click_button "Sign up" }.not_to change(User, :count)
  end

  it "log us in as new user if form is valid" do
    visit '/users/sign_up'
    fill_in 'First name', with: 'Greg'
    fill_in 'Last name', with: 'Heaphy'
    fill_in 'Email', with: 'Heaphy@heaphy.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    expect { click_button "Sign up" }.to change(User, :count)
  end
end

describe 'user login' do
  let(:user){ FactoryGirl.create(:user) }

  it 'should log in with valid info' do
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(current_path).to eq (journal_entries_path)
  end

  it 'should send us back to the sign in page with invalid info' do
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "wrongpassword"
    click_button 'Sign in'
    expect(current_path).to eq ('/users/sign_in')
  end
end
