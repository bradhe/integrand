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
      @tester.run_command('ls') do |io| 
        io.should be_a_kind_of IO
      end
    end

    it 'should pass a non-empty IO object to the block for a valid command' do
      @tester.run_command('ls') do |io| 
        io.read.should_not be_empty
      end
    end

    it 'should pass an empty IO object to the block for an invalid command' do
      @tester.run_command('this is not a valid command...') do |io| 
        io.read.should be_empty
      end
    end
  end

  describe '#chdir' do
    before do
      @tester = CommandLineTester.new
    end

    it 'should change directories when asked to' do
      dir = Dir.pwd

      @tester.chdir '/'
      Dir.pwd.should == '/'
      Dir.chdir dir
    end
  end
end
