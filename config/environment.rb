# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Betafisha::Application.initialize!

ActiveRecord::Base.logger.auto_flushing = true
ActiveRecord::Base.logger.level = Logger::INFO
