class BetsLoaderController < ApplicationController

    def api_test
      respond_to do |format|
        format.html {  
          }
        format.js { 
          @ligue = League.find_by_id( params[:sport_id].gsub("league_", "").to_i )
          }
      end
    end
      
end
