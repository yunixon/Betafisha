begin
#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"


Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end



while $running do

  # TODO: CALL PARSER HERE

  
  sleep 60
end 

end
