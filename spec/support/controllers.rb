require 'spec_helper'

def stub_signin(user = nil)
  user ||= FactoryGirl.create :user
  controller.stub(:current_user).and_return(user)
end
