require 'spec_helper'

describe Integrand::BuildRunner do
  fixtures :builds, :integrations

  before do
    @build = builds(:build1)

    # For some reason this is broken in the fixture
    @build.integration = integrations(:integration_with_id)

    @build_runner = Integrand::BuildRunner.new @build
  end

  describe '#output_file' do
    it 'should return a new IO on first call' do
      # TODO: Figure out why Tempfile doesn't implement IO...
      @build_runner.output_file.should be_a_kind_of Tempfile
    end

    it 'should return the same IO on second call' do
      first_output_file = @build_runner.output_file
      @build_runner.output_file.should.equal? first_output_file
    end
  end

  describe '#should_build?' do
    it 'should return true if update returns true' do
      # source_dir should exist.
      @build_runner.build.stub!(:source_dir).and_return(Dir.pwd)
      @build_runner.stub!(:update).and_return(true)

      @build_runner.should_build?.should be_true
    end

    it 'should return false if update returns false because source_dir does not exist' do
      # source_dir should exist.
      @build_runner.build.stub!(:source_dir).and_return('bullshit directory')
      @build_runner.should_not_receive(:update)

      # Run this bitch!
      @build_runner.should_build?
    end

    it 'should attempt to update if the directory exists' do
      # source_dir should exist.
      @build_runner.build.stub!(:source_dir).and_return(Dir.pwd)
      @build_runner.should_receive(:update)

      # It should call clone
      @build_runner.should_build?.should be_false
    end

    it 'should return true if source_dir does not exist and clone is successful' do
      @build_runner.build.stub!(:source_dir).and_return('bullshit directory')
      @build_runner.stub!(:clone).and_return(true)
      @build_runner.should_build?.should be_true
    end
  end
  
  describe '#run_build' do
    before do
      @build = @build_runner.build
    end

    it 'should update the build status to STATUS_NO_UPDATE if should_build? is false' do
      @build_runner.build.stub!(:source_dir).and_return('bullshit directory')
      @build_runner.stub!(:should_build?).and_return(false)

      # The build commands should not be executed if the build shouldn't run.
      @build_runner.should_not_receive(:exec_prebuild_command)
      @build_runner.should_not_receive(:exec_build_command)

      @build_runner.run_build
      @build.status.should == Build::STATUS_NO_UPDATE
    end

    it 'should update the build status to STATUS_RUNNING when it starts the build' do
      @build_runner.stub!(:should_build?).and_return(true)
      @build_runner.stub!(:exec_prebuild_command).and_return(nil)
      @build_runner.stub!(:exec_build_command).and_return(nil)
      @build_runner.stub!(:name).and_return('TROLOLOLO')
      @build_runner.build.stub!(:source_dir).and_return(Dir.pwd)

      @build.should_receive(:update_attribute).with(:status, Build::STATUS_RUNNING)
      @build.should_receive(:update_attribute).with(:status, Build::STATUS_COMPLETE)
      @build_runner.run_build
    end
  end
end
