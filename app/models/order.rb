class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date,  presence: true
  validate :estimated_delivery_date_is_future

  before_validation :generate_code
  
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Time.zone.today
      errors.add(:estimated_delivery_date, 'deve ser uma data futura')
    end
  end
end
