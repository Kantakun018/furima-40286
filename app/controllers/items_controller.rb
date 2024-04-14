class ItemsController < ApplicationController

  before_action :move_to_signin, except: [:index]

  def index
    query = "select * from items order by created_at desc"
    @items = Item.find_by_sql(query)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_fee_id,
      :prefecture_id,
      :days_until_shipping_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end

  def move_to_signin
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end