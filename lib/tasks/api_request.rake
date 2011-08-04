desc "getting api response"

task :get_api_response => :environment do
  
  running = true
    sleep 10
  #while (running) do
    include BetsLoaderHelper
    set_data
   # 
  #end
  
end