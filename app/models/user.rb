class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  has_many :clips
  has_and_belongs_to_many :groups

  after_save :create_groups

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

  def create_groups
    response = HTTParty.get("https://api.github.com/users/#{name}/orgs")
    return unless response.body

    json = ActiveSupport::JSON.decode(response.body)
    json.each do |organization|
      group = Group.where(uid: organization['id'].to_s)
        .first_or_create(name: organization['login'])
      groups << group unless groups.exists?(group.id)
    end
  end

end
