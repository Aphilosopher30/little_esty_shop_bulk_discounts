
class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @upcoming_holidays = [] #HolidayAPI.upcoming
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

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])

    @discount.update({threshold: params[:threshold], percentage: params[:percentage]})

    redirect_to "/merchant/#{@merchant.id}/discounts/#{@discount.id}"

    # pet = Pet.find(params[:id])
    # if pet.update(pet_params)
    #   redirect_to "/pets/#{pet.id}"
    # else
    #   redirect_to "/pets/#{pet.id}/edit"
    #   flash[:alert] = "Error: #{error_message(pet.errors)}"
    # end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    Discount.find(params[:discount_id]).destroy
    redirect_to "/merchant/#{@merchant.id}/discounts"
  end


end
