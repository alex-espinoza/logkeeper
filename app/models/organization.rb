class Organization < ActiveRecord::Base
  has_many :organization_users
  has_many :users, :through => :organization_users

  validates_length_of :name, :within => 1..100
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  accepts_nested_attributes_for :organization_users, :users
end