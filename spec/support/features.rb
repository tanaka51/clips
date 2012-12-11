require 'spec_helper'

def prepare_auth(user = nil)
  user ||= FactoryGirl.create :user_with_groups

  auth_param = {
    provider: user.provider,
    uid: user.uid,
    info: {
      nickname: user.name
    }
  }

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(auth_param)
end

def do_signin(user = nil)
  prepare_auth(user)
  visit root_path
  click_on 'signin_button'
end
