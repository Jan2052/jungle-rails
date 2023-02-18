# app/models/user.rb
    
class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase #no whitespace, change to lower case
    user = User.find_by(email: email)

    if user && user.authenticate(password) #uses has_secure_password
      return user
    else
      return nil
    end
  end

end