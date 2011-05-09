class Build < ActiveRecord::Base
  has_one :integration

  STATUS_RUNNING  = 0
  STATUS_COMPLETE = 1
  STATUS_FAILED   = 2
  STATUS_ENQUEUED = 3
end
