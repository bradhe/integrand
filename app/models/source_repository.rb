class SourceRepository < ActiveRecord::Base
  GIT = "git"
  HG = "hg"

  validates_presence_of :type
  validates_presence_of :path
end
