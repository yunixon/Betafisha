module AdminHelper
	def get_bookmaker_values ( bookmaker_name, table_name )
		values = case bookmaker_name
   			when "Gamebookers" then Gamebooker.where( :table_name => table_name )
   			when "Betredkings" then Betredking.where( :table_name => table_name )
   			else "default"
		end	
	end
end
