class BetafishaTable < ActiveRecord::Base
        attr_accessible :bookmaker_id, 
                        :sport_id, 
                        :ligue_id, 
                        :team_one_id, 
                        :team_two_id, 
                        :sportsmen_id, 
                        :bet_type_id, 
                        :team_one_coef, 
                        :team_two_coef, 
                        :sportsmen_coef
end
