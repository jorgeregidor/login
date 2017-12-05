require 'rails_helper'

RSpec.describe PagesController do
	
	describe "PagesController home logged" do

		before do
			@user = User.create(username: "testUser" , password: "123456", password_confirmation: "123456", fail_counter: 0 )
			session[:user_id] = @user.id
  		end

  		it 'GET #home go into' do
			get :home
      		expect(response).to render_template(:home)
		end

	end

	describe "PagesController home not logged" do

		before do
			session[:user_id] = nil
  		end

  		it 'GET #home redirect to loggin' do
			get :home
      		expect(response).to redirect_to login_path
		end

	end
end