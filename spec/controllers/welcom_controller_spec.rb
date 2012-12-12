require 'spec_helper'

describe WelcomController do

  describe "GET 'index'" do
    let!(:group_name) { 'apple' }

    before do
      if user
        user.groups << FactoryGirl.create(:group, name: group_name)
        stub_signin(user)
      end
      get 'index', group_name: group_name
    end

    context "given a user" do
      let(:user) { FactoryGirl.create :user }

      it "redirects to clips_path" do
        response.should redirect_to clips_path(group_name: group_name)
      end
    end

    context "not given a user" do
      let(:user) { nil }

      it "returns http success" do
        response.should be_success
      end
    end
  end

end
