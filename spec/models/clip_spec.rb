require 'spec_helper'

describe Clip do
  describe "validation" do
    it { should validate_presence_of :code }
  end
end
