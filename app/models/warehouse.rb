class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :description, :address, :cep, presence: true
  validates :code, length: {is: 3}
  validates :code, uniqueness: true

  def full_description
    "#{code} - #{name}"
  end
end
