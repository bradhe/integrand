require 'git'
require File.dirname(__FILE__) + '/../source.rb'

# TODO: Make this module include branching in the logic
module Integrand::Source::Git
  include Integrand::Source

  def clone
    !!::Git.clone(repository_connection_string, source_dir.to_s)
  end

  def update
    g = ::Git.open source_dir
    previous_commits = g.log.count

    # Now pull and check to see if there are any new commits
    # TODO: Implement the SHA thinger here.
    g.pull and return previous_commits != g.log.count
  end

  private
    # Compare the SHA of the last build with a commit
    def compare_shas(commit)
      # TODO: Implement this thing
      false
    end
end
