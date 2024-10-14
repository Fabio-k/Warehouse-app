require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when brand_name is empty' do
        supplier = Supplier.new(brand_name: '', corporate_name: 'Nintendo company', registration_number: '1234-234', 
            full_address: 'Av shinbuko, 234', city: 'Tokyo', state: 'Tokyo', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when corporate_name is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: '', registration_number: '1234-234', 
            full_address: 'Av shinbuko, 234', city: 'Tokyo', state: 'Tokyo', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when registration_number is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '', 
            full_address: 'Av shinbuko, 234', city: 'Tokyo', state: 'Tokyo', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when full_address is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '1234-234', 
            full_address: '', city: 'Tokyo', state: 'Tokyo', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when city is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '1234-234', 
            full_address: 'Av shinbuko, 234', city: '', state: 'Tokyo', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when state is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '1234-234', 
            full_address: 'Av shinbuko, 234', city: 'Tokyo', state: '', email: 'Nintendo@nintendo.com')
        result = supplier.valid?
        expect(result).to eq false
      end

      it 'false when email is empty' do
        supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '1234-234', 
            full_address: 'Av shinbuko, 234', city: 'Tokyo', state: 'Tokyo', email: '')
        result = supplier.valid?
        expect(result).to eq false
      end
    end
  end

  describe '#description' do
    it 'show corporate name and registration number' do
      supplier = Supplier.new(brand_name: 'Nintendo', corporate_name: 'Nintendo company', registration_number: '1234-234', 
      full_address: 'Av shinbuko, 234', city: 'Tokyo', state: 'Tokyo', email: 'Nintendo@nintendo.com')

      expect(supplier.description).to eq 'Nintendo company - 1234-234'
    end
  end
end
