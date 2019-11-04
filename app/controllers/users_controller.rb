class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @items = current_user.buy_items.includes(:item_images).recently.where(task: [:waiting_shipping, :rating_seller, :rating_buyer])
  end
end
