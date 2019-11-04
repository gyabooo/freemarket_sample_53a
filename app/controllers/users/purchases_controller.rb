class Users::PurchasesController < ApplicationController
  def purchase
    @items = current_user.buy_items.includes(:item_images).recently.where(task: [:waiting_shipping, :rating_seller, :rating_buyer])
  end

  def purchased
    @items = current_user.buy_items.includes(:item_images).recently.where(task: :complete)
    render :purchase
  end
end
