class Integration < ActiveRecord::Base
  attr_accessor :source_repository
  has_one :source_repository

  validates_presence_of :name, :message => 'Integration name cannot be empty.'
  validates_uniqueness_of :name, :message => 'You already have an integration by this name.'
#  validates_presence_of :path, :message => 'Please supply a path name.'
  validates_presence_of :source_repository, :message => 'Please include information about your source repository.'

#  validate :path do
#    errors.add(:path, 'Please supply a writable location on the file system.') unless File.writable?(path) and File.directory?(path)
#  end
end
