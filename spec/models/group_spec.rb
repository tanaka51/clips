require 'spec_helper'

describe Group do
  it { should have_and_belong_to_many :users }
end
