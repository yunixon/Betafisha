# coding: utf-8

class BetsLoaderController < ApplicationController

    layout 'admin'
    def api_test
      
     @coefficients_info =  GameBookersOdd.find( :all, :order => "id desc", :limit => 250 )
      
      #respond_to do |format|
        #format.html {#@coefficients_info = BookmakerCoefficients.find(:all, :order => "id desc", :limit => 250) }
      #  format.js { @coefficients_info = BookmakerCoefficients.find(:all, :order => "id desc", :limit => 250) }
      #end
    end
      
end
