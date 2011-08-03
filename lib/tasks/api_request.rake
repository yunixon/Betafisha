desc "getting api response"

task :get_api_response => :environment do
  
  include BetsLoaderHelper
  set_data
  
end