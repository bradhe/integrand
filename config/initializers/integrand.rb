Dir[File.join("lib", "**/*.rb")].each do |f|
  require f
end
