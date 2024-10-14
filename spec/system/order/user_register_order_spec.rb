require 'rails_helper'

describe 'user register order' do
  it 'if authnticated' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'with success' do
    user = User.create!(name: 'Fabio', email: 'fabio@gmail.com', password: 'senha123')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    
    supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
    full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
    full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.full_description, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '12/10/2024'
    click_on 'Gravar'
    
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'Samsung Electronics Ltda'
    expect(page).to have_content 'Pedido cadastrado com sucesso'
    expect(page).to have_content "Pedido ABCD1234"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Asics co - 2345-032'
    expect(page).to have_content 'Usuário Responsável: Fabio - fabio@gmail.com'
    expect(page).to have_content 'Data Prevista de Entrega: 12/10/2024'
  end
end