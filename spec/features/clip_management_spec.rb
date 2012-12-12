# -*- coding: utf-8 -*-
require 'spec_helper'

feature 'Clip managemant' do
  given!(:group_name) { 'apple' }
  given!(:user)       { FactoryGirl.create :user }

  background do
    user.groups << FactoryGirl.create(:group, name: group_name)

    do_signin(user)
  end

  scenario 'User creates a new clip' do
    visit new_clip_path(group_name: group_name)

    fill_in 'clip_code', with: 'test test test test'
    click_button 'Create Clip'

    expect(page).to have_text 'clip was successfuly created'
    expect(page).to have_text 'test test test test'
  end

  scenario 'User edits a clip' do
    clip = FactoryGirl.create :clip, code: 'hogehoge', user: user
    visit edit_clip_path(group_name: group_name, id: clip.id)

    fill_in 'clip_code', with: 'test test test test'
    click_button 'Update Clip'

    expect(current_path).to eq clip_path(group_name: group_name, id: clip.id)
    expect(page).to have_text 'clip was successfuly updated'
    expect(page).to have_text 'test test test test'
  end
end
