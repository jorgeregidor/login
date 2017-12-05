class PagesController < ApplicationController
  before_action :check_current_user

  def home
  end

  private

	  def check_current_user
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]	
	  	redirect_to login_url if @current_user.nil?
	  end
end
