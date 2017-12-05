class SessionController < ApplicationController
  
  def new	
  	redirect_to root_url if session[:user_id]
  end

  def create
  	if params[:username].empty? || params[:password].empty?
  		flash.now.alert = 'Username or password are empty'
  		render :new
  	else
	  	user = User.find_by(username: params[:username])
		if user 
			if user.fail_counter == 3
				flash.now.alert = 'User is Bloqued'
				render :new
			else
				if user.authenticate(params[:password])
			   		session[:user_id] = user.id
			   		user.update( fail_counter: 0)
			    	redirect_to root_url
			    else
			    	user.fail_counter += 1
			    	user.save
			    	flash.now.alert = 'Username or password is invalid'
			    	render :new
		  		end
			end
		else
		  flash.now.alert = 'Username or password is invalid'
		  render :new
		end
	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Logged out!'
  end
end
