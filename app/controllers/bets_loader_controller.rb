# coding: utf-8

class BetsLoaderController < ApplicationController

    def api_test
      respond_to do |format|
        format.html {  
          }
        format.js { 
          @ligue = Ligue.find_by_id( params[:sport_id].gsub("ligue_", "").to_i )
          }
      end
    end
      
end
