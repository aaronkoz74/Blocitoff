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
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Item was removed from your list - Congratulations!"
    redirect_to user_path(@user)
  end

  private

  def item_params
    params.require(:item).permit(:description)
  end

  def only_permit_current_user
    @user = User.find(params[:user_id])
    unless user_signed_in? && current_user == @user
      redirect_to root_path
      flash[:notice] = "You must be logged in as user to add or delete items."
    end
  end
end
