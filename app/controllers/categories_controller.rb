class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def show
    @category = Category.find(params[:id])
    @items = @category.belongs_items.page(params[:page]).per(PAGENATE)
    if @category.has_children?
      @categories = @category.children
    else
      @categories = @category.siblings
    end
  end

  private

  PAGENATE = 20

end
