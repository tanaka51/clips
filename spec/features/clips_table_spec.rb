require 'spec_helper'

feature 'Clip table' do
  background do
    FactoryGirl.create :clip, code: 'class Testing'
    FactoryGirl.create :clip, code: 'def say'
    FactoryGirl.create :clip, code: 'puts "hello, world!"'
    visit clips_path
  end


  scenario 'User watches clip table' do
    expect(page).to have_text('All Clips')
    Clip.all.each do |clip|
      expect(page).to have_text clip.id
    end
  end

  scenario 'User links to clip detail' do
    clip = Clip.first
    click_link clip.id

    expect(current_path).to eq(clip_path(clip.id))
  end
end
