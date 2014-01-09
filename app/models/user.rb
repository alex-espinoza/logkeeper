class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :organization_users
  has_many :organizations, :through => :organization_users

  validates :email, :email => true
  validates_length_of :email, :within => 6..100 # a@a.co
  validates_length_of :first_name, :within => 1..50
  validates_length_of :last_name, :within => 1..50
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_uniqueness_of :email, :case_sensitive => false
end
