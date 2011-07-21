# coding: utf-8
class BetsLoaderController < ApplicationController



   require 'rubygems'
   require "net/http"
   require 'rexml/document'
   require 'nokogiri'
   require 'open-uri'
    #require 'savon'

  def api_test
    
    # client = Savon::Client.new do
      # wsdl.document = "https://api.betfair.com/global/v3/BFGlobalService.wsdl"
      # wsdl.namespace = "http://www.betfair.com/publicapi/v3/BFGlobalService/"
    # end

    #res = client.request :login, :body => {:request => {:ip_address => 0,
    #                                                    :location_id => 0,
    #                                                    :password => 'vistadog123',
    #                                                    :product_id => 82,
    #                                                    :username => 'axgusev',
    #                                                    :vendor_softwareId => 0}}
    #@doc = Nokogiri::XML(res.to_xml)


     uri = URI.parse('http://xml.gamebookers.com/sports/basketball.xml');
     res = Net::HTTP.get_response(uri);
    
      xmldoc = REXML::Document.new(res.body)
     
      @doc = Nokogiri::XML(res.body)
      @events = Array.new
      @events = xmldoc.elements.each("//event") { |f| f }

  end
end
