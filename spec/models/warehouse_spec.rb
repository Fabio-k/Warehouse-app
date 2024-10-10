require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        warehouse  = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
            area: 10_000, description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'false when code is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
            area: 10_000, description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'false when address is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '2500-000', city: 'Rio de Janeiro',
            area: 10_000, description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'false when cep is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio de Janeiro',
            area: 10_000, description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'false when city is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '2500-000', city: '',
            area: 10_000, description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'false when area is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
            area: '', description: 'descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'false when description is empty' do
        warehouse  = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
            area: 10_000, description: '')

        result = warehouse.valid?

        expect(result).to eq false
      end
    end

    it 'false when code is already in use' do
      Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
            area: 10_000, description: 'descrição')
      second_warehouse  = Warehouse.create(name: 'Niteroi', code: 'RIO', address: 'Avenida X', cep: '3424-746', city: 'São Paulo',
            area: 23_000, description: 'Galpão de mário porte')
      third_warehouse  = Warehouse.create(name: 'Toronto', code: 'TOR', address: 'North York centre', cep: '5324-534', city: 'Toronto',
            area: 55_044, description: 'Galpão para distribuição de estoque')

      first_result = second_warehouse.valid?
      second_result = third_warehouse.valid?

      expect(first_result).to eq false
      expect(second_result).to eq true
    end

    it 'false when code dont have 3 letters' do
      less_than_three = Warehouse.new(name: 'Rio', code: 'RI', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
      area: 10_000, description: 'descrição')
      more_than_three = Warehouse.new(name: 'Rio', code: 'TORT', address: 'Endereço', cep: '2500-000', city: 'Rio de Janeiro',
      area: 10_000, description: 'descrição')

      first_result = less_than_three.valid?
      second_result = more_than_three.valid?

      expect(first_result).to eq false
      expect(second_result).to eq false
    end

  end
end
