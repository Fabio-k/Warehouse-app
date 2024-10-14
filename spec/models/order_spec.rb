require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'has to have a code' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-07-09')

      result = order.valid?

      expect(result).to be true

    end  

    it 'has to have a estimated_delivery_date' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user)

      result = order.valid?

      expect(result).to be false

    end

    it 'has to have a valid estimated_delivery_date' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-15-09')

      result = order.valid?

      expect(result).to be false

    end
  end

  describe 'generates a random code' do
    it 'creates a new order' do
      user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
      supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
          full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-10-09', code: '')

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
      first_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-05-09', code: '')
      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '1904-07-10', code: '')

      expect(second_order.code).not_to eq first_order.code
    end

  end
end
