class Integration < ActiveRecord::Base
  has_one :source_repository

  validates_presence_of :name
  validates_presence_of :filesystem_path
  validates_presence_of :source_control_path
end
