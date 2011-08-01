namespace :db do
  desc "Create root admin"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "admin",
                         :email => "admin@betafisha.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)
    
    user = User.create!( :name => "kirillivanov",
                         :email => "dxkxzx@gmail.com",
                         :password => "111111",
                         :password_confirmation => "111111")
    
  end 
end

