require 'rails_helper'

describe 'user see details of warehouse' do
  it 'and see additional information' do
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
    
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Almeida do Aeroporto, 1000, CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para carga internacionais')
  end

  it 'and return to homepage' do
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Almeida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para carga internacionais')
    
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'voltar'

    expect(current_path).to eq root_path
  end
end
