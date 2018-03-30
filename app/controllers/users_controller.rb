class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to user_url, notice: "User succesfully created!"
    else
        render :new
    end
  end


  private


end
