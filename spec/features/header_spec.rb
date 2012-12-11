# -*- coding: utf-8 -*-
require 'spec_helper'

feature "Header" do
  given!(:group_name) { 'apple' }
  given!(:user)       { FactoryGirl.create :user }

  background do
    user.groups << FactoryGirl.create(:group, name: group_name)

    do_signin(user)
  end

  scenario "User sees header" do
    visit root_path(group_name: group_name)
    expect(page).to have_selector('div.navbar')
  end

  scenario "User links to clip table in header link" do
    visit root_path(group_name: group_name)

    click_link 'All Clips'

    expect(current_path).to eq clips_path(group_name: group_name)
  end

  scenario "User links to clip detail in header link" do
    visit root_path(group_name: group_name)

    click_link 'New Clip'

    expect(current_path).to eq new_clip_path(group_name: group_name)
  end

end
