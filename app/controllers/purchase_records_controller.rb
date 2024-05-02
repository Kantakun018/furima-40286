class PurchaseRecordsController < ApplicationController

  before_action :get_target_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_records = PurchaseRecord.all
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif (current_user.id == @item.user_id) || (@purchase_records.exists?(item_id: @item.id))
      redirect_to root_path
    else
      @purchase_address = PurchaseAddress.new
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_record_params)

    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def get_target_item
    @item = Item.find(params[:item_id])
  end

  def purchase_record_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :street_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,                     # 商品の値段
      card: purchase_record_params[:token],    # カードトークン
      currency: 'jpy'                          # 通貨の種類（日本円）
    )
  end
end
