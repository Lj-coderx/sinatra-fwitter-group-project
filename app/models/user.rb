class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :email, :username, :password
  has_many :tweets

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
