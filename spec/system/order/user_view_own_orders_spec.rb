require 'rails_helper'

describe 'user see its orders' do
  it 'and should be authenticate' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'and should not see others orders' do
    user = User.create!(name: 'Davi', email: 'davi@gmail.com', password: 'senha123')
    other_user = User.create!(name: 'Rodnei', email: 'rodnei@gmail.com', password: 'senha123')

    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    
    supplier = Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
    full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    first_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(warehouse: warehouse, supplier: supplier, user: other_user, estimated_delivery_date: 1.week.from_now)
          
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).to have_content second_order.code
    expect(page).not_to have_content third_order.code
  end
end