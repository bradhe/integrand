class Integration < ActiveRecord::Base
  validates_presence_of :name, :message => 'Integration name cannot be empty.'
  validates_uniqueness_of :name, :message => 'You already have an integration by this name.'
  validates_presence_of :repository_connection_string, :message => 'Please supply a repository path'
end
