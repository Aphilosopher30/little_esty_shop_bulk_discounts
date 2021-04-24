class Discount < ApplicationRecord
  validates_presence_of :threshold
  validates_presence_of :percentage

  belongs_to :merchant
  # has_many :items, through: :merchant
  # has_many :invoice_items, through: :items
  # has_many :invoices, through: :invoice_items
  # has_many :customers, through: :invoices
  # has_many :transactions, through: :invoices
end
