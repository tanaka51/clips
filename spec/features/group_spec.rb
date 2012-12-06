require 'spec_helper'

feature 'Group' do

  scenario 'User chooses group' do
    user = FactoryGirl.create :user_with_groups
    do_signin(user)

    expect(page).to have_select('groups', options: user.groups.pluck(:name))
  end

  scenario "User dose'nt chooses group before signin" do
    visit root_path
    expect(page).to_not have_select('group')
  end
end
