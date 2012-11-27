require 'securerandom'

class Clip < ActiveRecord::Base
  attr_accessible :code, :access_id

  validates :code, presence: true

  before_create :generate_access_id

  ACCESS_ID_LENGTH = 10

  private
  def generate_access_id
    # SecureRandom#hex returns string that length is twice of given number length
    random_token = SecureRandom.hex(ACCESS_ID_LENGTH/2)
    if self.class.where(access_id: random_token).empty?
      self.access_id = random_token
    else
      generate_access_id
    end
  end
end
