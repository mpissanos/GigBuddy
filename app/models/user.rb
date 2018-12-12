class User < ActiveRecord::Base
  has_many :items
  has_secure_password
  validates :username, presence: true
end
