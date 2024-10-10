describe 'user remove a warehouse' do
  it 'with success' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
      address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'SDU'
  end

  it 'and dont remove other warehouses' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
      address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
        address: 'Rua das Mangueira', cep: '4003-202', description: "Pequeno galpão")

    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'MCZ'
    expect(page).not_to have_content 'SDU'
  end
end