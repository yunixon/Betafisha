namespace :db do
  desc "Create root admin"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "admin",
                         :email => "admin@betafisha.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)
    
    User.create!( :name => "kirillivanov",
                  :email => "dxkxzx@gmail.com",
                  :password => "111111",
                  :password_confirmation => "111111") 
                         
     Sports.create!( :name => "basketball")
     Sports.create!( :name => "football") 
     Sports.create!( :name => "formula_one") 
     Sports.create!( :name => "horse")
                               
  end 
  
end

