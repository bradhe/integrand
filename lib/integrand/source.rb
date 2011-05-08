require File.dirname(__FILE__) + '/../integrand.rb'

module Integrand::Source
  def source_dir
    File.join(Integrand::Application.source_dir, Digest::SHA1.hexdigest(name)).to_s
  end

  def fetch
    if Dir.exists? source_dir

    else
      Dir.mkdir source_dir unless Dir.exists? source_dir
    end
  end

  def clone
    raise 'Not implemented.'
  end

  def update
    raise 'Not implemented.'
  end
end
