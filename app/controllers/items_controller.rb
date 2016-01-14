class ItemsController < ApplicationController
  before_action :set_user
  before_action :only_permit_current_user, only: [:new, :create, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = @user.items.build(item_params)
    @item.user = @user

    if @item.save
      flash[:notice] = "Item was saved."
    else
      flash[:error] = "There was an error saving the item.  Please try again."
    end

    respond_to do |format|
      format.html do
        redirect_to user_path(@user)
      end
      format.js
    end
  end

  def destroy
    @item = @user.items.find(params[:id])

    if @item.destroy
      flash.now[:notice] = "Item was removed from your list - Congratulations!"

    else
      flash[:alert] = "Item could not be removed from your list.  Try again."
    end

    respond_to do |format|
      format.html do
        redirect_to root_url
      end
      format.js
    end
  end

  private

  def item_params
    params.require(:item).permit(:description)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def only_permit_current_user
    unless user_signed_in? && current_user == @user

      respond_to do |format|
        format.html do
          flash[:alert] = "You must be logged in as that user to add or delete items."
          redirect_to user_path(@user), status: 303
        end
        format.js do
          render 'only_permit_current_user.js.erb'
        end
      end
    end
  end
end
