class User < ActiveRecord::Base
  has_secure_password
  has_many :teams
  has_many :students, through: :teams
  has_many :cards

  def create_authenticity_token
    self.authenticity_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
