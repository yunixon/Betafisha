require 'spec_helper'

describe "Pages" do
  before (:each) do
    #register and confirm new user
    @user = Factory(:user)
    visit "http://localhost:3000/users/confirmation?confirmation_token=#{@user.confirmation_token}"
  end

  describe "GET /pages if guest" do
    it "should redirect to login page" do
      visit pages_path
      current_path.should == user_session_path
    end
  end

  describe "GET /pages if user" do
    it "should be successful" do
      #visit /pages
      visit pages_path
      current_path.should == user_session_path

      # fill login form
      fill_in 'Адрес электронной почты', :with => 'dxkxzx@admin.com'
      fill_in 'Пароль', :with => 'pleaseasd'
      click_button 'Войти' 

      #redirect via root path
      visit pages_path
      current_path.should == root_path
    end
  end

  describe "GET /pages if admin" do
    it "should be successful" do
      # set user as admin
      @user.toggle!(:admin)

      #visit /pages
      visit pages_path
      current_path.should == user_session_path

      # fill login form
      fill_in 'Адрес электронной почты', :with => 'dxkxzx@admin.com'
      fill_in 'Пароль', :with => 'pleaseasd'
      click_button 'Войти' 

      #redirect via root path
      visit pages_path
      current_path.should == pages_path
    end
  end
end