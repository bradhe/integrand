require File.dirname(__FILE__) + '/command_line'

module Integrand
  class BuildRunner
    attr_accessor :integration
    include Integrand::CommandLine

    def initialize(integration)
      self.integration = integration
    end

    def should_build?
      # Given a repository, see if we need to 
      return update if File.exists? source_dir

      # Source dir doesn't exist so clone the repo.
      return clone
    end

    def build
      return unless should_build?

      # Make sure there isn't a build in the queue.
      Build.where(:integration_id => integration.id).order(:created_at).first

      # If there isn't then enqueue a build
    end

    def run_prebuild
      run_command prebuild_command do |io, status|
        # Do something here...
      end
    end

    def run_build
      run_command build_command do |io, status|
        # Do someting here too...
      end
    end

    # Proxy some calls to our integration.
    def repository
      raise "No integration specified" if self.integration.nil?
      self.integration.repository
    end

    def name
      raise "No integration specified" if self.integration.nil?
      self.integration.name
    end

    def prebuild_command
      raise "No integration specified" if self.integration.nil?
      self.integration.prebuild_command
    end

    def build_command
      raise "No integration specified" if self.integration.nil?
      self.integration.build_command
    end
  end
end
