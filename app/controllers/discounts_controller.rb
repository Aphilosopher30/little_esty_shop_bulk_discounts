class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @upcoming_holidays = HolidayAPI.upcoming
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_discount = @merchant.discounts.create({threshold: params[:threshold], percentage: params[:percentage]})

    if new_discount.save
     redirect_to "/merchant/#{@merchant.id}/discounts"
    else
      flash.notice = "Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0"
      redirect_to "/merchant/#{@merchant.id}/discounts/new"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:discount_id])


    if @discount.update({threshold: params[:threshold], percentage: params[:percentage]})
      redirect_to "/merchant/#{@merchant.id}/discounts/#{@discount.id}"
    else
      flash.notice = "Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0"
      redirect_to "/merchant/#{@merchant.id}/discounts/#{@discount.id}/edit"
    end

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
