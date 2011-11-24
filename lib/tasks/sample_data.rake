
namespace :db do
  desc "Fill db"
  task :populate => :environment do

    User.delete_all

    admin = User.create!(:username => "admin",
                         :email => "dxkxzx@gmail.com",
                         :password => "qwerty",
                         :password_confirmation => "qwerty")
    admin.toggle!(:admin)
  end
end


namespace :db do
    desc "reset db"
    task :r => :environment do
      puts "Recreating db... please wait!"
      Rake::Task['db:drop'].execute
      Rake::Task['db:create'].execute
      Rake::Task['db:migrate'].execute
      #Rake::Task['db:populate'].execute
  end

end

