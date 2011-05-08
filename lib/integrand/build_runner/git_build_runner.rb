require File.dirname(__FILE__) + '/../build_runner'
require File.dirname(__FILE__) + '/../source/git'

module Integrand
  class GitBuildRunner < Integrand::BuildRunner
    include Integrand::Source::Git
  end
end
