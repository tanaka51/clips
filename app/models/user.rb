class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  has_many :clips
  has_and_belongs_to_many :groups

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  private
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
