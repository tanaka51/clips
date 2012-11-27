require 'spec_helper'
require 'securerandom'

describe Clip do
  describe "validation" do
    it { should validate_presence_of :code }
  end

  describe "before_create" do
    it "sets access_id using SecureRandom.hex" do
       # SecureRandom#hex returns string that length is twice of given number length
      SecureRandom.should_receive(:hex)
        .with(Clip::ACCESS_ID_LENGTH/2)
        .and_return('random_token')
      clip = described_class.create!(code: 'test')
      expect(clip.access_id).to_not be_nil
    end
  end
end
