require 'open3'

module Integrand::CommandLine
  def chdir(path)
    Dir.chdir path
  end

  def run_command(cmd, *args, &blk)
    Open3.popen3(cmd, args, blk) { |i,o,e| blk.call(o) }
  end
end
