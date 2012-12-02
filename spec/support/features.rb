require 'spec_helper'

def do_signin(user = nil)
  user ||= FactoryGirl.create :user

  auth_param = {
    provider: user.provider,
    uid: user.uid,
    info: {
      nickname: user.name
    }
  }

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(auth_param)

  visit root_path
  click_on 'signin_button'
end
