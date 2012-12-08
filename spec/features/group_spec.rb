# -*- coding: utf-8 -*-
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

  scenario "System creates groups to users when signin" do
    user = FactoryGirl.build :user, name: 'testuser'
    response_body = <<EOF
[
  {
    "login": "test-group",
    "id": 1234567
  }
]
EOF
    stub_request(:get, "https://api.github.com/users/#{user.name}/orgs").
      to_return(
         body: response_body,
         status: 200,
         headers: { 'Content-Length' => response_body.size })

    do_signin(user)

    expect(page).to have_select('groups', options: ["test-group"])
  end
end
