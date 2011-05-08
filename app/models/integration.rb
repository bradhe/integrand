class Integration < ActiveRecord::Base
  has_one :source_repository

  validates_presence_of :name, :message => 'Integration name cannot be empty.'
  validates_uniqueness_of :name, :message => 'You already have an integration by this name.'
  validates_presence_of :path, :message => 'Please supply a path name.'
  validates_presence_of :source_repository, :message => 'Please include information about your source repository.'
end
