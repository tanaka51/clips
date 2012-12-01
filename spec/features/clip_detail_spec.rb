require 'spec_helper'

feature 'Clip detail' do
  given!(:code) { <<-CODE
test1
test2
test3
test4
  CODE
  }
  given!(:clip) { FactoryGirl.create :clip, code: code }

  scenario 'User sees highliting code' do
    visit clip_path(id: clip.access_id)

    expect(page).to have_css('.CodeRay')
    expect(page).to have_text(code)
  end

  scenario 'User links to edit to click edit link' do
    visit clip_path(id: clip.access_id)

    click_on 'Edit'

    expect(current_path).to eq(edit_clip_path(id: clip.access_id))
  end
end
