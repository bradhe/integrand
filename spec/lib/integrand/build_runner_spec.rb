require 'spec_helper'

describe Integrand::BuildRunner do
  fixtures :builds

  before do
    @build_runner = Integrand::BuildRunner.new builds(:build1)
  end

  describe '#should_build?' do
    it 'should return true if update returns true' do
      # source_dir should exist.
      @build_runner.should_receive(:source_dir).and_return(Dir.pwd)
      @build_runner.should_receive(:update).and_return(true)

      @build_runner.should_build?.should be_true
    end

    it 'should return false if update returns false because source_dir does not exist' do
      # source_dir should exist.
      @build_runner.should_receive(:source_dir).and_return('bullshit directory')
      @build_runner.should_not_receive(:update)

      # Run this bitch!
      @build_runner.should_build?
    end

    it 'should return false if update returns false' do
      # source_dir should exist.
      @build_runner.should_receive(:source_dir).and_return(Dir.pwd)
      @build_runner.should_receive(:update).and_return(false)
      @build_runner.should_build?.should be_false
    end

    it 'should return true if source_dir does not exist and clone is successful' do
      @build_runner.should_receive(:source_dir).and_return('bullshit directory')
      @build_runner.should_receive(:clone).and_return(true)
      @build_runner.should_build?.should be_true
    end
  end
  
  describe '#run_build' do
    before do
      @build = @build_runner.build
    end

    it 'should update the build status to STATUS_NO_UPDATE if should_build? is false' do
      @build_runner.should_receive(:should_build?).and_return(false)

      # The build commands should not be executed if the build shouldn't run.
      @build_runner.should_not_receive(:exec_prebuild_command)
      @build_runner.should_not_receive(:exec_build_command)

      # GO GO GO!
      @build_runner.run_build
      @build.status.should == Build::STATUS_NO_UPDATE
    end

    it 'should update the build status to STATUS_RUNNING when it starts the build' do
      @build_runner.should_receive(:should_build?).and_return(true)

      # Mock out the commands so that we don't do anything
      @build_runner.should_receive(:exec_prebuild_command).and_return(nil)
      @build_runner.should_receive(:exec_build_command).and_return(nil)

      # Part of the source integration...need to add a name.
      @build_runner.should_receive(:name).and_return('TROLOLOLO')

      # Does this twice, should have better API for this...
      @build_runner.should_receive(:source_dir).and_return(Dir.pwd)
      @build_runner.should_receive(:source_dir).and_return(Dir.pwd)

      @build.should_receive(:update_attribute).with(:status, Build::STATUS_RUNNING)
      @build.should_receive(:update_attribute).with(:status, Build::STATUS_COMPLETE)
      @build_runner.run_build
    end
  end
end
