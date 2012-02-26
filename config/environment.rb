# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Betafisha::Application.initialize!

#ActiveRecord::Base.logger.auto_flushing = 1
#ActiveRecord::Base.logger.level = Logger::INFO
ActiveRecord::Base.connection.execute "SET collation_connection = 'utf8_general_ci' "
