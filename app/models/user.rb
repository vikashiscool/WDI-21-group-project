class User < ActiveRecord::Base
  has_secure_password
  has_many :friendables
  has_many :users, through: :friendables
  has_many :posts
  has_many :comments
  
  def self.confirm(email_param, password_param)
    user = User.find_by_email(email_param)
    user.authenticate(password_param)
  end
end
