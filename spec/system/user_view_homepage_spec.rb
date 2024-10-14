require 'rails_helper'

describe 'user visits homepage' do
  it 'and see app name' do 
    #Arrange
    
    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link 'Galpões & Estoque', href: root_path
  end

  it 'and see the listed warehouses' do
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
        address: 'Rua das Mangueira', cep: '4003-202', description: "Pequeno galpão")

    visit root_path
    expect(page).not_to have_content('Não existem galpões cadastrados')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('Área: 60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('Área: 50000 m2')
  end

  it 'and there are no warehouses' do
    visit root_path

    expect(page).to have_content('Não existem galpões cadastrados')
  end
end