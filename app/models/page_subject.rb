class PageSubject < ActiveRecord::Base
 	attr_accessible :name
 	
 	has_many :pages
end
