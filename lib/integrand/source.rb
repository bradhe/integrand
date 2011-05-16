require File.dirname(__FILE__) + '/../integrand.rb'

module Integrand::Source
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

  def clean
    Dir.delete source_dir
  end

  def should_build
    clone and return true unless Dir.exist? source_dir

    # Otherwise, if there's an update, enqueue a build
    update
  end
end
