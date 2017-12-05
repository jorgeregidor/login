require 'rails_helper'

RSpec.describe SessionController do
	
	let(:username_OK) { "testUser"}
	let(:username_Fail) { "aaaaaa" }
	let(:password_OK) { "123456"}
	let(:password_Fail) { "111111" }

	before(:all) do
    	@user = User.create(username: "testUser" , password: "123456", password_confirmation: "123456", fail_counter: 0 )
  	end

	describe "SessionController test" do
 
			  it 'GET #new not logged' do
			  	get :new
      			expect(response).to render_template(:new)
      			expect(session[:user_id]).to eq nil
			  end
			  
			  it 'POST #create user empty' do
			  	post :create, params: { username: "" , password: password_OK}
      			expect(flash[:alert]).to eq "Username or password is empty"
			  end

			  it 'POST #create bad user' do
			  	post :create, params: { username: username_Fail , password: password_OK}
      			expect(flash[:alert]).to eq "Username or password is invalid"
			  end

			  it 'POST #create bad password fail_counter ++1' do
			  	@user.update(fail_counter: 0)
			  	post :create, params: { username: username_OK , password: password_Fail}
      			expect(User.first.fail_counter).to eq 1
      			expect(flash[:alert]).to eq "Username or password is invalid"
			  end

			  it 'POST #create bad password fail_conunter 3' do
			  	@user.update(fail_counter: 3)
			  	post :create, params: { username: username_OK , password: password_Fail}
      			expect(User.first.fail_counter).to eq 3
      			expect(flash[:alert]).to eq "User is Bloqued"
			  end

			  it 'POST #create succesfull' do
			  	@user.update(fail_counter: 0)
			  	post :create, params: { username: username_OK , password: password_OK}
      			expect(response).to redirect_to root_path
      			expect(session[:user_id]).not_to eq nil
			  end

			  it 'DELETE #destroy succesfull' do
			  	delete :destroy
      			expect(response).to redirect_to login_path
      			expect(flash[:notice]).to eq "Logged out!"
      			expect(session[:user_id]).to eq nil
			  end
 	end

 	after(:all) do
    	@user.destroy
  	end
end