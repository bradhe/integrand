module Integrand
  class Application
    def self.source_dir
      @@source_dir
    end

    def self.source_dir=(dir)
      @@source_dir = dir
    end
  end
end
