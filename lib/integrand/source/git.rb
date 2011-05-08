require 'git'
require File.dirname(__FILE__) + '/../source.rb'

module Integrand::Source::Git
  include Integrand::Source

  def clone
    !!::Git.clone(repository_connection_string, source_dir.to_s)
  end

  def update
    g = Git.open source_dir

    unless should_build = g.fetch.blank?
      # Check last build, if SHAs don't exist then we need to build
      # Commits are stored most recent first
      should_build = compare_shas g.log.first
    end

    should_build
  end

  private
    # Compare the SHA of the last build with a commit
    def compare_shas(commit)
      # TODO: Implement this thing
      false
    end
end
