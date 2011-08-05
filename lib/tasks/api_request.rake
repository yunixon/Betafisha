

desc "getting api response"

task :get_api_response => :environment do
   
   require 'rubygems'
   require "net/http"
   require 'rexml/document'
   require 'nokogiri'
   require 'open-uri'
   require 'savon' 
          
  uri = 'http://xml.gamebookers.com/sports/basketball.xml'
  doc_gb = Nokogiri::XML::Reader( open( uri ) ) 
   
  #BookmakerCoefficients.destroy_all
  
  $running = true
  Signal.trap("TERM") do
    $running = false
  end
 # ActiveRecord::Base.logger.info $running.to_s
          
     # ActiveRecord::Base.logger.info "!!! Time now #{ Time.now }\n"
     # sleep 10
  while $running do
    
    #ActiveRecord::Base.logger.auto_flushing = true
    #ActiveRecord::Base.logger.info "!!! Time now #{ Time.now }\n"
    
    
    uri = 'http://xml.gamebookers.com/sports/basketball.xml'
    doc_gb = Nokogiri::XML::Reader( open( uri ) ) 
    
    doc_gb.each do |node|
      if node.node_type ==  Nokogiri::XML::Reader::TYPE_ELEMENT
         if node.name == "last_modified"
            ActiveRecord::Base.logger.auto_flushing = true
            ActiveRecord::Base.logger.info "!!! Time now #{ Time.now }\n"
         end
         if node.name == "eventName"
            bookmaker = BookmakerCoefficients.create! (:bookmaker_id => 1)       
        end
      end
    end
  
    sleep 10
   end 
    
end
