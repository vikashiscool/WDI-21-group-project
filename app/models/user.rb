class User < ActiveRecord::Base
  has_secure_password
  has_many :friendables
  has_many :users, through: :friendables
  has_many :posts
  has_many :comments
end
