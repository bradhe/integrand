require File.dirname(__FILE__) + '/command_line'

module Integrand
  class BuildRunner
    attr_accessor :integration
    include Integrand::CommandLine

    def should_build?
      # Given a repository, see if we need to 
      return update if File.exists? source_dir

      # Source dir doesn't exist so clone the repo.
      return clone
    end

    def run_prebuild

    end

    def run_build

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
  end
end
