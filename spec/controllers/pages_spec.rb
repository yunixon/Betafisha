require 'spec_helper'

describe PagesController do
  
  before (:each) do
    @user = Factory(:user)
    @user.toggle!(:admin)
    login_user(@user)
  end
  
  describe "GET 'index'" do
    it "should be successful" do
    	#get pages_path
      #response.should be_success
    end
  end
end
