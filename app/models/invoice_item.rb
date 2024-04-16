class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def applicable_discount
    discount = self.discounts
      .where("discounts.threshold <= #{self.quantity}")
      .select("discounts.id")
      .order(percentage: :desc)

    if discount.first == nil
      return nil
    else
      return discount.first.id
    end
  end
end
