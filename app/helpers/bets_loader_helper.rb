module BetsLoaderHelper
   
   require 'rubygems'
   require "net/http"
   require 'rexml/document'
   require 'nokogiri'
   require 'open-uri'
   require 'savon'
  
  def set_data
      ActiveRecord::Base.logger.info "!!!!!!"
     # uri = 'http://xml.gamebookers.com/sports/basketball.xml'
     # @doc_gb = Nokogiri::XML::Reader( open( uri ) )
  end

end
 