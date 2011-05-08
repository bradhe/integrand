require 'git'
require File.dirname(__FILE__) + '/../source.rb'

module Integrand::Source::Git
  include Integrand::Source

  def clone
    !!::Git.clone(repository_connection_string, source_dir.to_s)
  end

  def update
    
  end
end
