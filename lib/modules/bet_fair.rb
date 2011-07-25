class BetFair
  
  include RequestTypes
  
  def self.query (query)
    
    if query == ALL_LIGUES_FOOTBALL_ODDS_TO_WIN
      query 
    elsif query == ALL_LIGUES_BASKETBALL_ODDS_TO_WIN
      query 
    elsif query == ALL_LIGUES_ICE_HOCKEY_ODDS_TO_WIN
      query 
    else
      "wrong request!"
    end 
     
  end
  
end

