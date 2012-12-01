# -*- coding: utf-8 -*-
require 'spec_helper'

feature 'Clip managemant' do

  scenario 'User creates a new clip' do
    visit root_path

    fill_in 'clip_code', with: 'test test test test'
    click_button 'Create Clip'

    expect(page).to have_text 'clip was successfuly created'
    expect(page).to have_text 'test test test test'
  end

  scenario 'User edits a clip' do
    clip = FactoryGirl.create :clip, code: 'hogehoge'
    visit edit_clip_path(id: clip.access_id)

    fill_in 'clip_code', with: 'test test test test'
    click_button 'Update Clip'

    expect(current_path).to eq clip_path(id: clip.access_id)
    expect(page).to have_text 'clip was successfuly updated'
    expect(page).to have_text 'test test test test'
  end
end
