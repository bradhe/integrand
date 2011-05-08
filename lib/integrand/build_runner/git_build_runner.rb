module Integrand::BuildRunner
  class GitBuildRunner < BuildRunner
    include Integrand::Source::Git
  end
end
