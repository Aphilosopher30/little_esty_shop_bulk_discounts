require 'rails_helper'

describe 'new discount page' do
  it 'creates new discount'  do
    merchant1 = Merchant.create!(name: "Abe")

    visit "/merchant/#{merchant1.id}/discounts/new"

    # save_and_open_page

    fill_in "threshold", with: 10
    fill_in "percentage", with: 0.50

    click_button "Submit"

    expect(current_path).to eq("/merchant/#{merchant1.id}/discounts")

    expect(page).to have_content(0.50)
    expect(page).to have_content(10)
  end

end
