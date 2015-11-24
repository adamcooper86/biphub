class User < ActiveRecord::Base
  has_secure_password
  has_many :teams
  has_many :students, through: :teams
  has_many :cards
  has_many :observations
  has_many :records, through: :observations

  def create_authenticity_token
    self.authenticity_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    self.save
    self.authenticity_token
  end
end
