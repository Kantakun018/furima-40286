class PurchaseRecordsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    else
      @purchase_address = PurchaseAddress.new
      @item = Item.find(params[:item_id])
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_record_params)

    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def purchase_record_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :street_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
