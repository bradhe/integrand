require 'spec_helper'

class SourceTestHarness
  attr_accessor :repository_connection_string, :name
end

class GitSourceWrapper < SourceTestHarness
  include Integrand::Source::Git
end

describe 'source wrapper' do
  describe 'git' do
    it 'should be able to clone public repositories' do
      f = GitSourceWrapper.new
      f.name = 'Test Harness Thinger'
      f.repository_connection_string = 'git://github.com/bradhe/dumbos.git'
      f.clone.should be_true
    end
  end
end
