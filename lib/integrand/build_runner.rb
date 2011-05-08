module Integrand
  class BuildRunner
    attr_accessor :integration

    def should_build?
      # Given a repository, see if we need to 
      return update if File.exists? source_dir

      # Source dir doesn't exist so clone the repo.
      return clone
    end
  end
end
