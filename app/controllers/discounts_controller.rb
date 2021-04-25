class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_discount = @merchant.discounts.create({threshold: params[:threshold], percentage: params[:percentage]})

    new_discount.save

    redirect_to "/merchant/#{@merchant.id}/discounts"

    # if item.save
    #   redirect_to "/merchants/#{@merchant.id}/items"
    # else
    #   flash[:alert] = "ERROR: Item not created."
    #   redirect_to "/merchants/#{@merchant.id}/items/new"
    # end
  end


  def show
    @discount = Discount.find(params[:discount_id])
  end


end
