Dir[File.join(Rails.root.join("lib"), "**/*.rb")].each do |f|
  require f
end

Integrand::Application.source_dir = File.expand_path(File.dirname(__FILE__) + '/../../tmp')
