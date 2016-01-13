class ItemsController < ApplicationController
  before_action :only_permit_current_user, only: [:new, :create, :destroy]

  def new
    @user = User.find(params[:user_id])
    @item = Item.new
  end

  def create
    @user = User.find(params[:user_id])
    @item = @user.items.build(item_params)
    @item.user = @user

    if @item.save
      redirect_to user_path(@user), notice: "Item was saved."
    else
      flash[:error] = "There was an error saving the item.  Please try again."
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    if @item.destroy
      flash[:notice] = "Item was removed from your list - Congratulations!"

    else
      flash[:alert] = "Item could not be removed from your list.  Try again."
    end

    respond_to do |format|
      format.html do
        redirect_to root_url
      end
      format.js #{ render js: 'destroy.js.erb' }
    end
  end

  private

  def item_params
    params.require(:item).permit(:description)
  end

  def only_permit_current_user
    @user = User.find(params[:user_id])
    unless user_signed_in? && current_user == @user
      flash[:alert] = "You must be logged in as that user to add or delete items."

      respond_to do |format|
        format.html do
          redirect_to user_path(@user), status: 303
          # flash[:notice] = "You must be logged in as that user to add or delete items."
        end
        format.js do
          # flash.now[:notice] = "You must be logged in as that user to add or delete items."
          # render js file with a flash alert saying
        end
      end
    end
  end
end
