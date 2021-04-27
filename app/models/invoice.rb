class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items



  enum status: [:cancelled, :in_progress, :complete]

  # def total_revenue
  #   invoice_items.sum("unit_price * quantity")
  # end

  has_many :discounts, through: :merchants

  def total_revenue
    non_disccounts = []
    self.merchants.each do |merchant|
      no_discount = merchant.discounts.create!(percentage: 0, threshold: 0)
      non_disccounts << no_discount.id
    end

    test = InvoiceItem.joins(:discounts)
      .where("invoice_items.invoice_id = ?", self.id)
      .where("discounts.threshold <= invoice_items.quantity")
      .group("invoice_items.id")
      .select("invoice_items.quantity, invoice_items.unit_price, max(discounts.percentage) as max_discount")

    total = test.sum do |record|
      record.quantity*record.unit_price*(1-record.max_discount)
    end

    non_disccounts.each do |no_discount|
      Discount.find(no_discount).destroy
    end

    return total
  end



  def total_revenue_merchant(merchant)
    no_discount = merchant.discounts.create!(percentage: 0, threshold: 0)

    test = InvoiceItem.joins(:discounts)
      .where("invoice_items.invoice_id = ?", self.id)
      .where("discounts.threshold <= invoice_items.quantity")
      .where("merchants.id = ?", merchant.id)
      .group("invoice_items.id")
      .select("invoice_items.quantity, invoice_items.unit_price, max(discounts.percentage) as max_discount")

    total = test.sum do |record|
      record.quantity*record.unit_price*(1-record.max_discount)
    end

    Discount.find(no_discount.id).destroy

    return total
  end
end
