require File.dirname(__FILE__) + '/command_line'

module Integrand
  class BuildRunner
    attr_accessor :build

    include Integrand::CommandLine

    def initialize(build)
      self.build = build
    end

    def should_build?
      return true if forced?
      return clone unless File.exists?(build.source_dir)
      update
    end

    def forced?
      build.forced
    end

    def run_build
      logger.debug "Building #{build.inspect} (#{build.source_dir || "NO SOURCE DIR"})"

      unless should_build?
        logger.debug "Should not build."
        build.update_attribute(:status, Build::STATUS_NO_UPDATE) and return
      end

      logger.debug "Should build."

      # We need to save the output for later.
      cumulative_status = 0

      # Flag that it's running
      build.update_attribute(:output_file, output_file.path)
      build.update_attribute(:status, Build::STATUS_RUNNING)

      pushd and chdir(build.source_dir)

      # If there is command to run
      unless integration.prebuild_command.blank?
        exec_prebuild_command do |io, status|
          output_file.write(io.read)
          cumulative_status = status
        end

        # If it's not zero, return or something
        if cumulative_status != 0
          logger.debug "Prebuild command returned #{cumulative_status || "No status given."}"

          output_file.rewind
          logger.debug "Output:\n#{output_file.read}"

          # TODO: Save this somewhere.
          output_file.close

          # Need to save this for later somewhere...
          build.update_attribute(:status, Build::STATUS_FAILED) and return
        end
      end

      exec_build_command do |io, status|
        output_file.write(io.read)
        cumulative_status = status
      end

      popd

      # Same deal as before...
      if cumulative_status != 0
        logger.debug "Build command failed thusly: #{cumulative_status}"
        output_file.close

        # Need to save this for later somewhere...
        build.update_attribute(:status, Build::STATUS_FAILED) and return
      end

      # Otherwise, set up to "Complete!"
      build.update_attribute(:status, Build::STATUS_COMPLETE)

      output_file.rewind
      logger.debug output_file.read
    end

    def exec_prebuild_command(&blk)
      logger.debug "Running prebuild command: #{integration.prebuild_command}"
      run_command integration.prebuild_command do |io, status|
        blk.call(io, status)
      end
    end

    def exec_build_command(&blk)
      logger.debug "Running build command: #{integration.prebuild_command}"
      run_command integration.build_command do |io, status|
        blk.call(io, status)
      end
    end

    def logger
      Rails.logger
    end

    # Proxy some calls to our integration.
    def repository
      integration.repository
    end

    def integration
      build.integration
    end

    def name
      integration.name
    end

    def output_file
      @output_file ||= Tempfile.new Digest::SHA1.hexdigest(build.started_at.to_s + name)
    end
  end
end
