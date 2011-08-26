# coding: utf-8

class BetsLoaderController < ApplicationController


    def api_test
      
      ActiveRecord::Base.logger.auto_flushing = true
      ActiveRecord::Base.logger.info  params[:sport_name]
     
      param = ''
      if params[:sport_name] == 'Баскетбол' 
          param = 'Basketball'      
      end
      
      if params[:sport_name] == 'Футбол'
          param = 'Football' 
      end
     
      if params[:sport_name] == 'Хоккей'
          param = 'Ice Hockey' 
      end
      
       if params[:sport_name] == 'Бейсбол'
          param = 'Baseball' 
      end
      
       if params[:sport_name] == 'Регби'
          param = 'Rugby' 
      end
      
       if params[:sport_name] == 'Американский футбол'
          param = 'American football' 
      end
      
      respond_to do |format|
        format.html { 
          
            if param == ''
              @coefficients_info = BetafishaTable.find(:all, :order => "id desc")
            else
              @coefficients_info = BetafishaTable.where(:sport_id => param ) 
            end
          
          }
        format.js { 
          
            if param == ''
              @coefficients_info = BetafishaTable.find(:all, :order => "id desc")
            else
              @coefficients_info = BetafishaTable.where(:sport_id => param ) 
            end
          
          }
      end
    end
      
end
