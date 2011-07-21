# Load the rails application

config.gem "nokogiri"

require File.expand_path('../application', __FILE__)



# Initialize the rails application
Oddschecker::Application.initialize!
