require 'spec_helper'

feature 'Clip table' do
  let!(:group_name) { 'apple' }
  let!(:user)       { FactoryGirl.create :user }

  background do
    group = FactoryGirl.create :group, name: group_name
    user.groups << group
    do_signin(user)

    FactoryGirl.create :clip, user: user, group: group, code: 'class Testing'
    FactoryGirl.create :clip, user: user, group: group, code: 'def say'
    FactoryGirl.create :clip, user: user, group: group, code: 'puts "hello, world!"'

    another_group = FactoryGirl.create :group, name: 'orange'
    FactoryGirl.create_list :clip, 5, user: user, group: another_group

    visit clips_path(group_name: group_name)
  end

  scenario 'User watches clips belongs in own group' do

    expect(page).to have_text('All Clips')

    Group.where(name: group_name).first.clips.each do |clip|
      expect(page).to have_text clip.id
    end

    Group.where(name: 'orange').first.clips.each do |clip|
      expect(page).to_not have_text clip.id
    end
  end

  scenario 'User links to clip detail' do
    clip = Clip.first
    click_link clip.id

    expect(current_path).to eq clip_path(group_name: group_name, id: clip.id)
  end
end
