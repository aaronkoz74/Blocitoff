class ItemsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.description = params[:item][:description]
    @user = User.find(params[:user_id])
    @item.user = @user

    if @item.save
      redirect_to user_path(@user), notice: "Item was saved."
    else
      flash[:error] = "There was an error saving the item.  Please try again."
    end
  end
end
