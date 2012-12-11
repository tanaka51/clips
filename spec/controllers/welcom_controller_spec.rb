require 'spec_helper'

describe WelcomController do

  describe "GET 'index'" do
    let!(:group_name) { 'apple' }

    before do
      user = FactoryGirl.create :user
      user.groups << FactoryGirl.create(:group, name: group_name)

      stub_signin(user)
      get 'index', group_name: group_name
    end

    it "returns http success" do
      response.should be_success
    end
  end

end
