require 'spec_helper'

class CommandLineTester
  include Integrand::CommandLine
end

describe 'Integrand::CommandLine' do
  describe '#run_command' do
    before do
      @tester = CommandLineTester.new
    end

    it 'should pass a valid IO object to the block' do
      @tester.run_command('ls') do |io, status|
        io.should be_a_kind_of IO
      end
    end

    it 'should pass a non-empty IO object to the block for a valid command' do
      @tester.run_command('ls') do |io, status|
        io.read.should_not be_empty
      end
    end

    it 'should status 0 to the block for a valid command' do
      @tester.run_command('ls') do |io, status|
        status.should be_a_kind_of Integer
        status.should == 0
      end
    end
  end

  describe '#chdir' do
    before do
      @tester = CommandLineTester.new
    end

    it 'should be able to pushd and popd and end up in the sample damn place' do
      current_pwd = Dir.pwd

      @tester.pushd
      @tester.chdir '/'

      Dir.pwd.should == '/'
      @tester.popd
      Dir.pwd.should == current_pwd
    end
  end
end
