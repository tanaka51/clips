require 'spec_helper'
require 'securerandom'

describe Clip do
  it { should belong_to :user }

  describe "validation" do
    it { should validate_presence_of :code }
    it { should validate_presence_of :user }
  end

  describe "before_create" do
    it "sets a random value to id (not sequential)" do
      clips = FactoryGirl.create_list :clip, 2

      # TODO: think better way
      expect(clips[0].id).to_not eq 1
      expect(clips[1].id).to_not eq 2
    end
  end
end
