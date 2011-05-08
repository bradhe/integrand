module Integrand::CommandLine
  def run_command(cmd, *args)
    IO.popen(args.unshift(cmd).join(' ')) do |f|

    end
  end
end
