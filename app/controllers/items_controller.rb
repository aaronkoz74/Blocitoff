class ItemsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @user = User.find(params:[:user_id])
    @item = @user.items.build(item_params)
    @item.user = current_user
  end

  private

  def item_params
    params.require(:item).permit(:task)
  end
end
