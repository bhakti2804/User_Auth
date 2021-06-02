
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
		if user_params[:username].match(/(\%27)|(\')|(\-\-)|(\%23)|(#)/) or user_params[:password].match(/(\%27)|(\')|(\-\-)|(\%23)|(#)/)
			flash[:register_errors] = ['SQL Injection detected'] 
			redirect_to '/signup'
		elsif user_params[:username].match(/((\%3C)|<)[^\n]+((\%3E)|>)/) or user_params[:password].match(/((\%3C)|<)[^\n]+((\%3E)|>)/)
			flash[:register_errors] = ['Cross Site Scripting detected'] 
			redirect_to '/signup'
		else
			user = User.create(user_params)
			if user.save
				redirect_to "/welcome/#{user.id}"
			else
				flash[:register_errors] = user.errors.full_messages
				redirect_to '/signup'
			end
		end
	end

	#Requires for Company ID, username and password to be filled
	private 
		def user_params
			params.require(:user).permit(:username, :password )
		end
end
