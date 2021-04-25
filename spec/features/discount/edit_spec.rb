require 'rails_helper'

RSpec.describe 'edit discount page' do

  it "defaults to current data" do

    merchant_a = Merchant.create!(name: 'Merchant 1')
    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

    visit "merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

    # save_and_open_page

    expect(page).to have_button('Submit Edit')
    # expect(find('form')).to have_content(discount_1a.percentage)
    # expect(page).to have_content(discount_1a.threshold)

  end

  it "give updates the data" do
    merchant_a = Merchant.create!(name: 'Merchant 1')
    discount_1a = merchant_a.discounts.create!(percentage: 0.10, threshold: 3)

    visit "merchant/#{merchant_a.id}/discounts/#{discount_1a.id}/edit"

    fill_in 'threshold', with: '20'
    fill_in 'percentage', with: '.40'

    click_button('Submit Edit')

    expect(current_path).to eq("/merchant/#{merchant_a.id}/discounts/#{discount_1a.id}")

    expect(page).to have_content(0.40)
    expect(page).to have_content(20)
  end

end


# expect().to have_content('Name')
# expect(find('form')).to have_content('Breed')
# expect(find('form')).to have_content('Adoptable')
# expect(find('form')).to have_content('Age')
