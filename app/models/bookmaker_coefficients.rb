# == Schema Information
#
# Table name: bookmaker_coefficients
#
#  id             :integer(4)      not null, primary key
#  bookmaker_id   :string(255)
#  sport_id       :string(255)
#  ligue_id       :string(255)
#  team_one_id    :string(255)
#  team_two_id    :string(255)
#  sportsmen_id   :string(255)
#  bet_type_id    :string(255)
#  team_one_coef  :string(255)
#  team_two_coef  :string(255)
#  sportsmen_coef :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class BookmakerCoefficients < ActiveRecord::Base
    
    attr_accessible :id, 
                    :bookmaker_id, 
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
