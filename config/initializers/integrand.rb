Dir[File.join(Rails.root.join("lib"), "**/*.rb")].each do |f|
  require f
end

Integrand::Application.source_dir = File.dirname(__FILE__) + '/../../tmp'
