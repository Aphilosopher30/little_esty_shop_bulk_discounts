require 'rails_helper'

describe 'new discount page' do
  it 'creates new discount'  do
    merchant1 = Merchant.create!(name: "Abe")

    visit "/merchant/#{merchant1.id}/discounts/new"

    fill_in "threshold", with: 10
    fill_in "percentage", with: 0.50

    click_button "Submit"

    expect(current_path).to eq("/merchant/#{merchant1.id}/discounts")

    expect(page).to have_content(0.50)
    expect(page).to have_content(10)
  end

  describe "sad paths: " do
    it "threshold cannot be less than 0" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/new"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")

      fill_in 'threshold', with: '-4'
      fill_in 'percentage', with: '0.40'

      click_button('Submit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/new")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end

    it "percentage cannot be less than 0" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/new"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")

      fill_in 'threshold', with: '4'
      fill_in 'percentage', with: '-0.40'

      click_button('Submit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/new")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end

    it "percentage cannot be more than 1" do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

      visit "/merchant/#{merchant_a.id}/discounts/new"

      expect(page).to have_no_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")

      fill_in 'threshold', with: '4'
      fill_in 'percentage', with: '22.0'

      click_button('Submit')

      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/new")
      expect(page).to have_content("Percentage must be a decimal between 0 and 1. And Threshold cannot be less than 0")
    end
  end


end
