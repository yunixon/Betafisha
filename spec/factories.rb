require 'factory_girl'

Factory.define :user do |u|
  u.username 'admin'
  u.email 'dxkxzx@admin.com'
  u.password 'pleaseasd'
  u.password_confirmation 'pleaseasd'
end