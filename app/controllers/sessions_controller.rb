
#Handles requests for Log in
class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token 
  	skip_before_action :authenticate_user!, :only => "reply", :raise => false

  	#Find the user by their user ID
  	#Gets called after Login button is clicked 
  	def welcome 
  		@user = User.find_by(id: params[:id])
  	end
	def create
		#user = User.find_by(username:login_params[:username]);	
		
		array = User.find_by_sql("
		  SELECT * FROM users
		  where username = '#{login_params[:username]}' and password = '#{login_params[:password]}';
		")
		
		@user = User.find_by(id: array.map(&:id))
		if @user 
			session[:user_id] = @user.id
			redirect_to "/welcome/#{@user.id}"
		else
			flash[:login_errors] = ['Invalid credentials'] 
			redirect_to '/'
		end
	end
	

	def current_user
    	return unless session[:user_id]
    	@current_user ||= User.find(session[:user_id])
  	end

  	def destroy 
	  	#User.find(session[:user_id]).destroy      
	    session[:user_id] = nil         
	    redirect_to '/login'
  	end

	#Makes sure the user has entered all two fields 
	private 
		def login_params
			params.require(:user).permit(:username, :password);
		end
end
