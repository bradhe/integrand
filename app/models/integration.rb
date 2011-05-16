class Integration < ActiveRecord::Base
  has_many :builds, :dependent => :destroy, :order => 'started_at DESC'

  validates_presence_of :name, :message => 'Integration name cannot be empty.'
  validates_uniqueness_of :name, :message => 'You already have an integration by this name.'
  validates_presence_of :repository, :message => 'Please supply a repository path'

  def last_build
    builds.order('created_at ASC').first
  end
end
