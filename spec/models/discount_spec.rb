require 'rails_helper'

describe Discount do
  describe "validations" do
    it { should validate_presence_of :threshold }
    it { should validate_presence_of :percentage }

    it {should validate_numericality_of(:threshold).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:percentage).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:percentage).is_less_than(1)}
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
