# coding: utf-8

class BetsLoaderController < ApplicationController

    layout 'admin'
    def api_test
      respond_to do |format|
        format.html { @coefficients_info = GameBookersOdd.find(:all, :order => "id desc", :limit => 250) }
        format.js { @coefficients_info = GameBookersOdd.find(:all, :order => "id desc", :limit => 250) }
      end
    end
      
end
