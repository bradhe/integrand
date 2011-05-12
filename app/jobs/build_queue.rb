class BuildQueue
  @queue = :build_queue

  def self.perform(build_id)
    Rails.logger.debug "Starting build for Build ID #{build_id}"

    build = Build.find build_id
    build.update_attribute :status, Build::STATUS_RUNNING

    Rails.logger.debug "Updated status..."

    begin
      # Run the build, I guess. Determine what build runner 
      # to run from here based on source control type
      build_runner = Integrand::GitBuildRunner.new(build)

      Railes.logger.debug "Beginning GIT build."

      build_runner.run_build

      Rails.logger.debug "Woops"
    rescue Exception => e
      # TODO: Log failure type
      Railes.logger.debug "Build failed with exception. " + e

      build.ended_at = Time.now
      build.status = Build::STATUS_FAILED
      build.save!
    end
  end
end
