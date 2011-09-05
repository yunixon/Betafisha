class BetsLoaderController < ApplicationController
    def api_test
      @sports = Sport.all
      respond_to do |format|
        format.html
        format.js { 
          @league = League.find_by_id( params[:sport_id].gsub("league_", "").to_i )
         }
      end
    end   
end
