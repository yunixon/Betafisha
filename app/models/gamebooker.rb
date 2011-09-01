class Gamebooker < ActiveRecord::Base
  COMMON_ATTRIBUTES = ['sport', 'league', 'event', 'country', 'participant']
  has_one :betredking
end
