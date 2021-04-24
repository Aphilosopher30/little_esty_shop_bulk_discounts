require 'rails_helper'

describe Discount do
  describe "validations" do
    it { should validate_presence_of :thresholt }
    it { should validate_presence_of :discount }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    # it { should have_many(:items).through(:merchant) }
    # it { should have_many(:invoice_items).through(:items) }
    # it { should have_many(:invoices).through(:invoice_items)}
    # it { should have_many(:customers).through(:invoices) }
    # it { should have_many(:transactions).through(:invoices) }
  end

end
