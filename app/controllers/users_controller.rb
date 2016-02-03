class UsersController < ApplicationController

  before_filter :only_permit_current_user

  def show
      @user = User.find(params[:id])
      @items = @user.items
  end

  private

  def only_permit_current_user
    @user = User.find(params[:id])
    unless user_signed_in? && current_user == @user

      respond_to do |format|
        format.html do
          flash[:alert] = "You must be logged in as that user to perform that action."
          redirect_to root_path, status: 303
        end
        format.js do
          render 'only_permit_current_user.js.erb'
        end
      end
    end
  end
end
