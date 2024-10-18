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
end