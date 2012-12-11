require 'spec_helper'

feature 'Welcome' do
  let!(:group) { FactoryGirl.create :group, name: 'apple' }
  let!(:user)  { FactoryGirl.create :user }

  background do
    user.groups << group

    prepare_auth(user)
    visit welcome_path
  end

  scenario 'User signins with button then show clip table in group' do
    click_on 'signin_button'

    expect(page.current_path).to eq '/apple/clips'
    expect(page).to have_text "apple"
    expect(page).to have_text "All Clips"
  end
end
