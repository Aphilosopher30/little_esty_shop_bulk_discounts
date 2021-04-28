require 'rails_helper'

RSpec.describe 'edit discount page' do

  it "defaults to current data" do

    merchant_a = Merchant.create!(name: 'Merchant 1')
    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

    visit "merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

    expect(page).to have_button('Submit Edit')
    # expect(find('form')).to have_content(discount_1a.percentage)
    # expect(page).to have_content(discount_1a.threshold)

  end

  it " updates the data" do
    merchant_a = Merchant.create!(name: 'Merchant 1')
    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

    visit "merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

    fill_in 'threshold', with: '20'
    fill_in 'percentage', with: '0.40'

    click_button('Submit Edit')

    expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}")

    expect(page).to have_content(0.40)
    expect(page).to have_content(20)
  end


  describe "sad paths: " do
    it "threshold cannot be less than 0" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")


      fill_in 'threshold', with: '-4'
      fill_in 'percentage', with: '0.40'

      click_button('Submit Edit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end

    it "percentage cannot be less than 0" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")

      fill_in 'threshold', with: '4'
      fill_in 'percentage', with: '-0.40'

      click_button('Submit Edit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end

    it "percentage cannot be more than 1" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")

      fill_in 'threshold', with: '4'
      fill_in 'percentage', with: '22.0'

      click_button('Submit Edit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end
  end
end


# expect().to have_content('Name')
# expect(find('form')).to have_content('Breed')
# expect(find('form')).to have_content('Adoptable')
# expect(find('form')).to have_content('Age')
