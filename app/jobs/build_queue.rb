class BuildQueue
  @queue = :build_queue

  def self.perform(build_id)
    build = Build.find build_id
    build.update_attribute :status, Build::STATUS_RUNNING

    begin
      # Run the build, I guess. Determine what build runner 
      # to run from here based on source control type
      build_runner = Integration::GitBuildRunner.new :build => build
      build_runner.run_build
    rescue Exception => e
      # TODO: Log failure type
      Rails.logger.fatal "Build failed with exception. " + e

      build.ended_at = Time.now
      build.status = Build::STATUS_FAILED
      build.save!
    end
  end
end
