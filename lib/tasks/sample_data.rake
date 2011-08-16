namespace :db do
  desc "Create root admin"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "admin",
                         :email => "admin@betafisha.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)
    
    User.create!( :name => "asdasd",
                  :email => "dfgdfgdfg@gmail.com",
                  :password => "111111",
                  :password_confirmation => "111111") 
                  
    User.create!( :name => "test",
                  :email => "test1@sadaasd.com",
                  :password => "111111",
                  :password_confirmation => "111111") 
                  
     User.create!( :name => "test 2",
                  :email => "test2@asdasdfd.com",
                  :password => "111111",
                  :password_confirmation => "111111") 
                                   
     Sport.create!( :name => "Футбол", :priority => 1)                     
     Sport.create!( :name => "Баскетбол", :priority => 2)
     Sport.create!( :name => "Хоккей", :priority => 3) 
     Sport.create!( :name => "Волейбол", :priority => 2)
     Sport.create!( :name => "Формула 1", :priority => 1) 
     Sport.create!( :name => "Скачки", :priority => 2) 
     
     
      Sport.all.each do |sport|
        1.times do
          sport.countries.create!( :name => "Россия", :priority => 1)
          sport.countries.create!( :name => "Англия", :priority => 3)
          sport.countries.create!( :name => "Испания", :priority => 1)
          sport.countries.create!( :name => "Италия", :priority => 2)
          sport.countries.create!( :name => "Бразилия", :priority => 1)
          sport.countries.create!( :name => "Германия", :priority => 2)
        end
      end
      
      
      Country.all.each do |country|
        1.times do
          country.ligues.create!( :name => "Первая лига", :priority => 2)
          country.ligues.create!( :name => "Вторая лига", :priority => 1)
        end
      end
                               
  end 
  
end

