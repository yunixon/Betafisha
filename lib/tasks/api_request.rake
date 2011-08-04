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
   
  BookmakerCoefficients.destroy_all
  
  doc_gb.each do |node|
    
    if node.node_type ==  Nokogiri::XML::Reader::TYPE_ELEMENT
       if node.name == "eventName"
          bookmaker = BookmakerCoefficients.create! (:bookmaker_id => 1)       
       end
    end
    
  end

end
