require File.dirname(__FILE__) + '/command_line'

module Integrand
  class BuildRunner
    attr_accessor :build

    include Integrand::CommandLine

    def initialize(build)
      self.build = build
    end

    def should_build?
      # Given a repository, see if we need to 
      return update if File.exists? source_dir

      # Source dir doesn't exist so clone the repo.
      return clone
    end

    def run_build
      logger.debug "Starting build..."

      unless should_build?
        logger.debug "Should not build. Getting outta here."
        build.update_attribute(:status, Build::STATUS_NO_UPDATE) and return
      end

      logger.debug "Should build. Starting!"

      # We need to save the output for later.
      tmp = Tempfile.new Digest::SHA1.hexdigest(build.started_at.to_s + name)
      cumulative_status = 0

      # Flag that it's running
      build.update_attribute(:status, Build::STATUS_RUNNING)

      run_prebuild do |io, status|
        tmp.write io.read

        cumulative_status = status
      end

      # If it's not zero, return or something
      if cumulative_status != 0
        tmp.close

        # Need to save this for later somewhere...
        build.update_attribute(:status, Build::STATUS_FAILED) and return
      end

      run_build do |io, status|
        tmp.write io.read
        cumulative_Status = status
      end

      # Same deal as before...
      if cumulative_status != 0
        tmp.close

        # Need to save this for later somewhere...
        build.update_attribute(:status, Build::STATUS_FAILED) and return
      end

      # Otherwise, set up to "Complete!"
      build.update_attribute(:status, Build::STATUS_COMPLETE)
    end

    def run_prebuild(&blk)
      run_command prebuild_command do |io, status|
        blk.call(io, status)
      end
    end

    def run_build
      run_command build_command do |io, status|
        # Do someting here too...
      end
    end

    def logger
      Rails.logger if defined?(Rails) and Rails.logger
    end

    # Proxy some calls to our integration.
    def repository
      raise "No integration specified" if self.build.integration.nil?
      self.build.integration.repository
    end

    def name
      raise "No integration specified" if self.build.integration.nil?
      self.build.integration.name
    end

    def prebuild_command
      raise "No integration specified" if self.build.integration.nil?
      self.build.integration.prebuild_command
    end

    def build_command
      raise "No integration specified" if self.build.integration.nil?
      self.build.integration.build_command
    end
  end
end
