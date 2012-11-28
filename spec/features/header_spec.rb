# -*- coding: utf-8 -*-
require 'spec_helper'

feature "Header" do

  scenario "User sees header" do
    visit root_path
    expect(page).to have_selector('div.navbar')
  end

  scenario "User links to clip table in header link" do
    visit root_path

    click_link 'All Clips'

    expect(current_path).to eq(clips_path)
  end

  scenario "User links to clip detail in header link" do
    visit root_path

    click_link 'New Clip'

    expect(current_path).to eq(new_clip_path)
  end

end
