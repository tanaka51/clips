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

  given(:user) { FactoryGirl.create :user, name: name }
  given(:name) { 'test-san' }

  background do
    do_signin(user)
  end

  scenario 'User sees highliting code' do
    visit clip_path(clip)

    expect(page).to have_css('.CodeRay')
    expect(page).to have_text(code)
  end

  scenario 'User sees author' do
    visit clip_path(clip)

    expect(page).to have_text(name)
  end

  scenario 'User links to edit to click edit link' do
    visit clip_path(clip)

    click_on 'Edit'

    expect(current_path).to eq(edit_clip_path(clip))
  end
end
