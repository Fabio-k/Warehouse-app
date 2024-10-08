require 'rails_helper'

describe 'user visits homepage' do
  it 'and see app name' do 
    #Arrange
    
    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'and see the listed warehouses' do
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000)

    visit('/')
    expect(page).not_to have_content('Não existem galpões cadastrados')

    expect(page).to have_content('Rio')
    expect(page).to have_content('código: SDU')
    expect(page).to have_content('cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('código: MCZ')
    expect(page).to have_content('cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'and there are no warehouses' do
    visit('/')

    expect(page).to have_content('Não existem galpões cadastrados')
  end
end