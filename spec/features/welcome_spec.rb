require 'spec_helper'

feature 'Welcome' do
  background do
    prepare_auth
    visit welcome_path
  end

  scenario 'User signins with button' do
    click_on 'signin_button'

    expect(page.current_path).to eq root_path
  end
end
