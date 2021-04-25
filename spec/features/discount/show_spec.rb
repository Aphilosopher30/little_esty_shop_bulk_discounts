require 'rails_helper'

describe 'Discount show page' do
  it 'displays all bulk discount information' do

    merchant_a = Merchant.create!(name: 'Merchant 1')
    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)
    discount_2a = merchant_a.discounts.create!(percentage: 0.25, threshold: 5)

    visit "merchant/#{merchant_a.id}/discounts/#{discount_1a.id}"

    expect(page).to have_content(discount_1a.id)
    expect(page).to have_content(discount_1a.percentage)
    expect(page).to have_content(discount_1a.threshold)
    
    expect(page).to have_no_content(discount_2a.id)
    expect(page).to have_no_content(discount_2a.percentage)
    expect(page).to have_no_content(discount_2a.threshold)
  end
end
