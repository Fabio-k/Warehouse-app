require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10,sku: 'TV32-SAMSU-SD34', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end

      it 'sku is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: 'TV 32', weight: 1800, width: 70, height: 45, depth: 10,sku: '', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end

      it 'weight is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10,sku: 'TV32-SAMSU-SD34', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end

      it 'width is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: 'TV 32', weight: 1800, width: '', height: 45, depth: 10,sku: 'TV32-SAMSU-SD34', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end

      it 'height is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: 'TV 32', weight: 1800, width: 70, height: '', depth: 10,sku: 'TV32-SAMSU-SD34', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end

      it 'depth is mandatory' do
        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
        product_model = ProductModel.new(name: 'TV 32', weight: 1800, width: 70, height: 45, depth: '',sku: 'TV32-SAMSU-SD34', supplier: supplier)
      
        result = product_model.valid?

        expect(result).to eq false
      end
    end
    
  end
end
