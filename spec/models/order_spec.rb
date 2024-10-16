require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'has to have a code' do
      order = Order.new()

      order.valid?

      expect(order.errors.include? :code).to be false

    end  

    context 'estimated_delivery_date' do
      it 'is obrigatory' do
        order = Order.new(estimated_delivery_date: '')

        order.valid?

        expect(order.errors.include? :estimated_delivery_date).to be true

      end

      it 'is a valid date' do
        order = Order.new(estimated_delivery_date: '2024-15-09')
  
        order.valid?
  
        expect(order.errors.include? :estimated_delivery_date).to be true
  
      end

      it 'cannot be a past date' do
        order = Order.new(estimated_delivery_date: 1.day.ago)
        
        order.valid?

        expect(order.errors.include? :estimated_delivery_date).to be true
        expect(order.errors[:estimated_delivery_date]).to include "deve ser uma data futura"
      end

      it 'cannot be a today\'s date' do
        order = Order.new(estimated_delivery_date: Time.zone.today)
        
        order.valid?

        expect(order.errors.include? :estimated_delivery_date).to be true
        expect(order.errors[:estimated_delivery_date]).to include "deve ser uma data futura"
      end

      it 'should be greater or equal tomorrow date' do
        order = Order.new(estimated_delivery_date: 1.day.from_now)
        
        order.valid?

        expect(order.errors.include? :estimated_delivery_date).to be false
      end
    end
    
  end

  describe 'generates a random code' do
    it 'creates a new order' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now, code: '')

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'and code is unique' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      first_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now, code: '')
      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now, code: '')

      expect(second_order.code).not_to eq first_order.code
    end

  end
end
