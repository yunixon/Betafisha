module SportsHelper

  def get_common_sports
    commons = Common.where( :table_name => "sports" )
    sports = Sport.all#.collect { |sport| !commons.find_by_name( sport.name ).nil? ? sport.name : "" }
    return sports
  end

end

