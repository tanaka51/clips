require 'spec_helper'

feature 'Clip detail' do
  given!(:code) { <<-CODE
test1
test2
test3
test4
  CODE
  }
  given!(:clip) { FactoryGirl.create :clip, code: code, user: user }
  given!(:group_name) { 'apple' }

  given(:user) { FactoryGirl.create :user, name: name }
  given(:name) { 'test-san' }

  background do
    user.groups << FactoryGirl.create(:group, name: group_name)
    do_signin(user)
    visit clip_path(group_name: group_name, id: clip.id)
  end

  scenario 'User sees highliting code' do
    expect(page).to have_css('.CodeRay')
    expect(page).to have_text(code)
  end

  scenario 'User sees author' do
    expect(page).to have_text(name)
  end

  scenario 'User links to edit to click edit link' do
    click_on 'Edit'

    expect(current_path).to eq edit_clip_path(group_name: group_name, id: clip.id)
  end
end
