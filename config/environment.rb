# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Integrand::Application.initialize!

# Setup the logger to be auto flushing in all cases.
Rails.logger.auto_flushing = true
