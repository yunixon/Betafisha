# coding: utf-8

class BetsLoaderController < ApplicationController


   require 'rubygems'
   require "net/http"
   require 'rexml/document'
   require 'nokogiri'
   require 'open-uri'
   require 'savon'
   
   include BetsLoaderHelper
    
    
    def api_test
      
    
      
      #set_data     
   
    respond_to do |format|
      format.html { @doc_gb = Array.new }
      format.js  {
          system "rake get_api_response &"
      }
    end

      
      # client = Savon::Client.new do
      # wsdl.document = "https://api.betfair.com/global/v3/BFGlobalService.wsdl"
      # wsdl.namespace = "http://www.betfair.com/publicapi/v3/BFGlobalService/"
      # end
# 
      # res = client.request :login,  :body => {  :request => {  :ip_address => 0,
                                                            # :location_id => 0,
                                                            # :password => 'vistadog123',
                                                            # :product_id => 82,
                                                            # :username => 'axgusev',
                                                            # :vendor_softwareId => 0 } }
#      
#      
#      
      # @doc_betfair = Nokogiri::XML( res.to_xml )


      #uri = URI.parse('http://xml.gamebookers.com/sports/basketball.xml');
      #res = Net::HTTP.get_response(uri);
    
      #xmldoc = REXML::Document.new(res.body)
     
 

      #uri = 'http://xml.gamebookers.com/sports/basketball.xml'
      #@doc_gb = Nokogiri::XML::Reader( open( uri ) )
      
      

        #@events = Array.new
        #@events = @doc.xpath("//event")
        
    end
    
    

  
end
