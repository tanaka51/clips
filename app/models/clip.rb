class Clip < ActiveRecord::Base
  attr_accessible :code

  belongs_to :user
  belongs_to :group

  validates :code, presence: true
  validates :user, presence: true

  acts_as_random_id
end
