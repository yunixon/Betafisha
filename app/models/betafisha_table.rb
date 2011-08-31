class BetafishaTable < ActiveRecord::Base
        attr_accessible :bookmaker_id, 
                        :sport_id, 
                        :league_id, 
                        :participant_one_id, 
                        :participant_two_id, 
                        :sportsmen_id, 
                        :bet_type_id, 
                        :participant_one_coef, 
                        :participant_two_coef, 
                        :sportsmen_coef
end
