require 'rails_helper'

describe 'discount page' do

  it 'shows all bulk discount information' do

    merchant_a = Merchant.create!(name: 'Merchant 1')
    merchant_b = Merchant.create!(name: 'Merchant 2')

    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)
    discount_2a = merchant_a.discounts.create!(percentage: 0.25, threshold: 5)
    discount_3a = merchant_a.discounts.create!(percentage: 0.50, threshold: 10)
    discount_1b = merchant_b.discounts.create!(percentage: 0.23, threshold: 7)


    visit "merchant/#{merchant_a.id}/discounts"


    within("#merchant-#{discount_1a.id}") do
      expect(page).to have_content(discount_1a.id)
      expect(page).to have_content(discount_1a.percentage)
      expect(page).to have_content(discount_1a.threshold)
    end
    within("#merchant-#{discount_2a.id}") do
      expect(page).to have_content(discount_2a.id)
      expect(page).to have_content(discount_2a.percentage)
      expect(page).to have_content(discount_2a.threshold)
    end
    within("#merchant-#{discount_3a.id}") do
      expect(page).to have_content(discount_3a.id)
      expect(page).to have_content(discount_3a.percentage)
      expect(page).to have_content(discount_3a.threshold)
    end

    expect(page).to have_no_content(discount_1b.id)
    expect(page).to have_no_content(discount_1b.percentage)
    expect(page).to have_no_content(discount_1b.threshold)
  end

  describe 'has links' do
    it 'for each discount' do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      merchant_b = Merchant.create!(name: 'Merchant 2')

      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)
      discount_2a = merchant_a.discounts.create!(percentage: 0.25, threshold: 5)
      discount_3a = merchant_a.discounts.create!(percentage: 0.50, threshold: 10)
      discount_1b = merchant_b.discounts.create!(percentage: 0.25, threshold: 7)

      visit "/merchant/#{merchant_a.id}/discounts"

      within("#merchant-#{discount_1a.id}") do
        expect(page).to have_link(discount_1a.id)
      end
      within("#merchant-#{discount_2a.id}") do
        expect(page).to have_link(discount_2a.id)
      end
      within("#merchant-#{discount_3a.id}") do
        expect(page).to have_link(discount_3a.id)
      end
      expect(page).to have_no_link(discount_1b.id)
    end

    it 'which link to discount show page' do
      merchant_a = Merchant.create!(name: 'Merchant 1')
      merchant_b = Merchant.create!(name: 'Merchant 2')

      discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)
      discount_2a = merchant_a.discounts.create!(percentage: 0.25, threshold: 5)
      discount_3a = merchant_a.discounts.create!(percentage: 0.50, threshold: 10)
      discount_1b = merchant_b.discounts.create!(percentage: 0.25, threshold: 7)

      visit "/merchant/#{merchant_a.id}/discounts"

      within("#merchant-#{discount_1a.id}") do
        click_link "#{discount_1a.id}"
        expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}")
      end

      visit "/merchant/#{merchant_a.id}/discounts"
  
      within("#merchant-#{discount_2a.id}") do
        click_link "#{discount_2a.id}"
        expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_2a.id}")
      end

      visit "/merchant/#{merchant_a.id}/discounts"

      within("#merchant-#{discount_3a.id}") do
        click_link "#{discount_3a.id}"
        expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_3a.id}")
      end

    end
  end

  describe "create new discount button" do

    it 'exists ' do
      merchant_a = Merchant.create!(name: 'Merchant 1')

      visit "/merchant/#{merchant_a.id}/discounts"

      expect(page).to have_link("new discount")
    end

    it ' goes to a new page to create the form' do
      merchant_a = Merchant.create!(name: 'Merchant 1')

      visit "/merchant/#{merchant_a.id}/discounts"

      expect(page).to have_link("new discount")
      click_link "new discount"
      expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/new")
    end


  end
end
