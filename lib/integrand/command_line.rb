require 'tempfile'

module Integrand::CommandLine
  def chdir(path)
    Dir.chdir path
  end

  def run_command(cmd, &blk)
    tmp = Tempfile.new Digest::SHA1.hexdigest(cmd)

    cmd.split("\n").reject { |s| s =~ /\s+/ }.each do |c|
      fd = File.popen(c)
      tmp.write fd.read
    end

    tmp.flush
    tmp.close

    blk.call(File.open tmp.path, 'r') if blk
  end
end
