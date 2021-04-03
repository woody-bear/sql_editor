class UserController < ApplicationController
  
  def index

  end
  
  def login
    
  end
  
  def signin
    user_id = params[:user_id]
    password = params[:password]
    nickname = params[:nickname]
    debugger

    render json: { success }
  end
end