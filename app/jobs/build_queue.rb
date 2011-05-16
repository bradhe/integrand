class BuildQueue
  @queue = :build_queue

  def self.perform(build_id)
    Rails.logger.debug "(#{build_id}) Starting build."
    build = Build.find build_id

    # Run the build, I guess. Determine what build runner 
    # to run from here based on source control type
    build_runner = Integrand::GitBuildRunner.new(build)
    build_runner.run_build
    Rails.logger.debug "(#{build_id}) Build complete."
  end
end
