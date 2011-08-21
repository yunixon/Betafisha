namespace :db do
  desc "Fill db"
  task :populate => :environment do
    
    Rake::Task['db:reset'].invoke
    
    admin = User.create!(:name => "admin",
                         :email => "admin@betafisha.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
                         
    admin.toggle!(:admin)
    
                                     
     Sport.create!( :name => "Футбол", :priority => 1 )                     
     Sport.create!( :name => "Баскетбол", :priority => 2 )
     Sport.create!( :name => "Хоккей", :priority => 3 ) 
     Sport.create!( :name => "Волейбол", :priority => 4 )
     Sport.create!( :name => "Формула 1", :priority => 5 ) 
     Sport.create!( :name => "Скачки", :priority => 6 ) 
     
     Country.create!( :name => "Россия", :priority => 1 )
     Country.create!( :name => "Англия", :priority => 2 )
     Country.create!( :name => "Испания", :priority => 3 )
     Country.create!( :name => "Италия", :priority => 4 )
     Country.create!( :name => "Бразилия", :priority => 5 )
     Country.create!( :name => "Германия", :priority => 6 )
     
     
     10.times do
       Ligue.create!( :name => "первая лига", :priority => 1 )
       Ligue.create!( :name => "вторая лига", :priority => 2 )  
     end
         
        
     Ligue.all.each do |ligue|
       ligue.sport = Sport.order('rand()').first
       ligue.country = Country.order('rand()').first
       ligue.save!
  
     end

  end 
  
end

