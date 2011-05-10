class Build < ActiveRecord::Base
  belongs_to :integration

  STATUS_RUNNING    = "running"
  STATUS_COMPLETE   = "complete"
  STATUS_FAILED     = "failed"
  STATUS_ENQUEUED   = "enqueued"
  STATUS_NO_UPDATE  = "skipped"

  before_create do
    self.started_at = Time.now
    self.status = STATUS_ENQUEUED
  end
end
