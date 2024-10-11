require 'rails_helper'

describe 'user edit warehouse' do
  it 'from the details page' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Rio'
    expect(page).to have_field 'Código', with: 'SDU' 
    expect(page).to have_field 'Cidade', with: 'Rio de Janeiro'
    expect(page).to have_field 'Área', with: 60_000
    expect(page).to have_field 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    expect(page).to have_field 'CEP', with: '20100-000'
    expect(page).to have_field 'Descrição', with: 'Galpão da zona portuária do Rio'
  end

  it 'with success' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão matriz'
    fill_in 'CEP', with: '23230-320'
    click_on 'Enviar'

    expect(page).to have_content 'Nome: Galpão matriz'
    expect(page).to have_content 'CEP: 23230-320'
    expect(page).to have_content 'Galpão atualizado com sucesso'
  end

  it 'with failed' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
        address: 'Avenida do Museu do Amanhã, 1000', cep: '20100-000', description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Área', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
    expect(page).to have_field 'Nome', with: 'Rio'
    expect(page).to have_field 'Código', with: 'SDU'
  end
end