require 'tempfile'

module Integrand::CommandLine
  def chdir(path)
    Dir.chdir path
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

      blk.call(File.open(tmp.path, 'r'), status.exitstatus) if blk
    rescue Exception => e
      raise "Invalid command: #{cmd}. " + e
    end
  end
end
