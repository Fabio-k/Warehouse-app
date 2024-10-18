require 'rails_helper'

describe 'user search for order' do
  it 'has to be authenticated' do
    user = User.create!(name: 'Guilherme', email: 'guilherme@gmail.com', password: 'senha123')

    login_as(user)
    visit root_path

    within 'nav' do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end

  end

  it 'from menu' do
    visit root_path

    within 'nav' do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'and find a order' do
    user = User.create!(name: 'Guilherme', email: 'guilherme@gmail.com', password: 'senha123')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    
    supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
    full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path

    within 'nav' do
      fill_in 'Buscar Pedido', with: order.code
      click_on 'Buscar'  
    end

    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Asics co'
  end

  it 'and find multiple orders' do
    user = User.create!(name: 'Guilherme', email: 'guilherme@gmail.com', password: 'senha123')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    second_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'São Paulo', area: 35_000, 
        address: 'Avenida paulista, 1320', cep: '20100-000', description: 'Galpão para armazenamento de entregas internacionais')
    
    supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
    full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU12345')
    first_order = Order.create!(warehouse: first_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU54321')
    second_order = Order.create!(warehouse: first_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    third_order = Order.create!(warehouse: second_warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)
  
    login_as(user)
    visit root_path

    within 'nav' do
      fill_in 'Buscar Pedido', with: 'SDU'
      click_on 'Buscar'  
    end

    expect(page).to have_content "Resultados da busca por: SDU"
    expect(page).to have_content '2 pedidos encontrado'
    expect(page).to have_content "SDU12345"
    expect(page).to have_content 'SDU54321'
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).not_to have_content 'GRU12345'
    expect(page).not_to have_content 'Galpão Destino: GRU - Aeroporto SP'
  end
end