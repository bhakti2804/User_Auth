
#Handles requests for Sign up
class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token 
  	skip_before_action :authenticate_user!, :only => "reply", :raise => false

  	#Redirects to signup html
	def signup

	end

	#Initializes a new user object
	def index
		user = User.new
	end

	#Creates a new user based on entered fields 
	#Gets called after Sign Up button is clicked
	def create
		user = User.create(user_params)
		if user.save
			redirect_to '/welcome'
		else
			flash[:register_errors] = user.errors.full_messages
			redirect_to '/signup'
		end
	end

	#Requires for Company ID, username and password to be filled
	private 
		def user_params
			params.require(:user).permit(:companyID, :username, :password )
		end
end
