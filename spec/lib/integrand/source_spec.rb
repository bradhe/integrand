require 'spec_helper'
require 'fileutils' # For removing a directory
require 'git' # For testing the update stuff...

class SourceTestHarness
  attr_accessor :repository, :name, :build
end

class GitSourceWrapper < SourceTestHarness
  include Integrand::Source::Git
end

describe 'Integrand::Source' do
  describe '::Git' do
    describe '#clone' do
      fixtures :builds

      before do
        @source = GitSourceWrapper.new
        @source.name = 'Test Harness Thinger'
        @source.repository = 'git://github.com/bradhe/dumbos.git'
        @source.build = builds(:build1)
      end

      it 'should be able to clone public repositories' do
        FileUtils.rm_rf @source.build.source_dir if File.exists? @source.build.source_dir
        @source.clone.should be_true
      end
    end

    describe '#update' do
      fixtures :builds

      before :all do
        # Create a test repo somewhere in temp.
        @tmp_git_repo = "#{Rails.root}/tmp/test_source_control"

        # Clean up from previous test runs if we can
        FileUtils.rm_rf @tmp_git_repo if File.exists? @tmp_git_repo
        Dir.mkdir @tmp_git_repo

        # Create one file, turn this in to a git repo, and commit this file.
        File.open("#{@tmp_git_repo}/test.txt", 'w') { |f| f.write "Hello, World!" }

        # Turn this in to a git repo and commit to it.
        ::Git.init @tmp_git_repo
        g = ::Git.open @tmp_git_repo
        g.add "#{@tmp_git_repo}/test.txt"
        g.commit "Initial commit of test repo."
      end

      before do
        @source = GitSourceWrapper.new
        @source.name = 'Test Harness Thinger'
        @source.repository = @tmp_git_repo
        @source.build = builds(:build1)

        # Create a clean repo and clone this stuff
        FileUtils.rm_rf(@source.build.source_dir) if File.exists?(@source.build.source_dir)
        @source.clone
      end

      it 'should return false when there has not been an update to the repository' do
        @source.update.should be_false
      end

      it 'should return true when there has been an update to the repository' do
        # TODO: Abstract this shit to it's own helper or whatever.
        File.open("#{@tmp_git_repo}/test.txt", 'w') { |f| f.write 'Lets update repo.' }
        g = ::Git.open @tmp_git_repo
        g.log.count.should == 1

        g.add "#{@tmp_git_repo}/test.txt"
        g.commit 'Another commit from the test suite.'

        # Just make sure that everything is working on this end.
        g.log.count.should == 2

        @source.update.should be_true
      end
    end
  end
end
