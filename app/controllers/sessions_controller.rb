
#Handles requests for Log in
class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token 
  	skip_before_action :authenticate_user!, :only => "reply", :raise => false

  	#Find the user by their user ID
  	#Gets called after Login button is clicked 
	def create
		user = User.find_by(companyID:login_params[:companyID]);	
		if user && user.authenticate(login_params[:password])
			session[:user_id] = user.id
			redirect_to '/welcome'
		else
			flash[:login_errors] = ['Invalid credentials'] 
			redirect_to '/'
		end
	end

	#Makes sure the user has entered all three fields 
	private 
			def login_params
		params.require(:login).permit(:companyID, :username, :password);
			end
end
