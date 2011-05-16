require 'tempfile'

module Integrand::CommandLine
  def pushd
    @dirs ||= []
    @dirs.push Dir.pwd
  end

  def chdir(path)
    Dir.chdir path
  end

  def popd
    Dir.chdir(@dirs.pop) unless @dirs.empty?
  end

  def run_command(cmd, &blk)
    tmp = Tempfile.new Digest::SHA1.hexdigest(cmd)

    begin
      pid, stdin, stdout, stderr = Open4::popen4 cmd
      ignored, status = Process::waitpid2 pid

      # Lets pass this off to a long-lived thing
      tmp.write stdout.read

      tmp.flush
      tmp.close

      blk.call(File.open(tmp.path, 'r'), status.exitstatus.to_i) if blk
    rescue => e
      raise "Invalid command: #{cmd}. " + e
    end
  end
end
