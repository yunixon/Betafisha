namespace :db do
  desc "Fill db"
  task :populate => :environment do
    
    Rake::Task['db:reset'].invoke
    
    admin = User.create!(:name => "admin",
                         :email => "admin@betafisha.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
                         
    admin.toggle!(:admin)
                                      
  end 
end

