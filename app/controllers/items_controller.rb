class ItemsController < ApplicationController

  before_action :move_to_signin, except: [:index, :show]
  before_action :get_target_item, only: [:show, :edit, :update, :destroy]
  before_action :get_purchase_records, only: [:index, :show, :edit]

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

  def show
  end

  def edit
    if (current_user.id != @item.user_id) || (@purchase_records.exists?(item_id: @item.id))
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
    end
    redirect_to root_path
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

  def get_target_item
    @item = Item.find(params[:id])
  end

  def get_purchase_records
    @purchase_records = PurchaseRecord.all
  end

end