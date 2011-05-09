require 'open3'
require 'tempfile'

module Integrand::CommandLine
  def chdir(path)
    Dir.chdir path
  end

  def run_command(cmd, &blk)
    tmp = Tempfile.new

    cmd.split("\n").reject { |s| s =~ /\s+/ }.each do |c|
      Open3.popen3(c) { |i,o,e| tmp.write(o.read) }
    end

    blk.call(tmp) if blk
  end
end
