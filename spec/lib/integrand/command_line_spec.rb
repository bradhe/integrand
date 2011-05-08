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
      @tester.run_command('ls') { |io| io.should be_a_kind_of IO }
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
