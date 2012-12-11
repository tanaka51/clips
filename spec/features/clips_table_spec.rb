require 'spec_helper'

feature 'Clip table' do
  let!(:group_name) { 'apple' }

  background do
    user = FactoryGirl.create :user
    user.groups << FactoryGirl.create(:group, name: group_name)
    do_signin(user)

    FactoryGirl.create :clip, user: user, code: 'class Testing'
    FactoryGirl.create :clip, user: user, code: 'def say'
    FactoryGirl.create :clip, user: user, code: 'puts "hello, world!"'
    visit clips_path(group_name: group_name)
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

    expect(current_path).to eq clip_path(group_name: group_name, id: clip.id)
  end
end
