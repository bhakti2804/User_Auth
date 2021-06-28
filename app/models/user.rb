#Validates the information entered by the user
class User < ApplicationRecord
  #has_secure_password   #used to encrypt and authenticate passwords using BCrypt

  id_format = 
  /\A
  (?:[0-9]+[a-z]|[a-z]+[0-9])[a-z0-9]*  #Must contain alphabets and numbers both
  \z/i

  password_format = 
  /\A                  
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
  /x

  username_format = 
  /\A                
  [a-zA-Z0-9_]*     #Must be either alphabets or numbers
  \z/


#  validates :companyID, presence: true,
 # 						          format: {with: id_format, message: 'has to be compulsorily alphanumeric'},
  #						          uniqueness: true
              
  validates :username, presence: true,
  					  uniqueness: true
  		   	
  validates :password, presence: true 
 #              length: {in: 8..15},
  #             format: { with: password_format, message: 'has to contain an Uppercase letter and a Digit'}, 
   #            on: :create
end
