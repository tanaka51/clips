require 'securerandom'

class Clip < ActiveRecord::Base
  attr_accessible :code

  validates :code, presence: true

  acts_as_random_id
end
