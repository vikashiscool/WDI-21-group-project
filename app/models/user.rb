class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  has_many :posts
  has_many :comments
  has_many :friendables
  has_many :passive_friendships, :class_name => "Friendable", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendables: { accepted: true}) }, :through => :friendables, :source => :friend
  has_many :passive_friends, -> { where(friendables: { accepted: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendables: { accepted: false}) }, :through => :friendables, :source => :friend
  has_many :requested_friendships, -> { where(friendables: { accepted: false}) }, :through => :passive_friendships, :source => :user


  def friends
    active_friends | passive_friends
  end

  def self.confirm(email_param, password_param)
    user = User.find_by_email(email_param)
    user.authenticate(password_param)
  end

end
