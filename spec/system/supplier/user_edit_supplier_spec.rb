require 'rails_helper'

describe 'user edit supplier' do
  it 'from the details page' do
    Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
        full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Asics'
    click_on 'Editar'

    expect(page).to have_content 'Editar fornecedor'
    expect(page).to have_field 'Nome da marca', with: "Asics"
  end

  it 'with success' do
    Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
        full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Asics'
    click_on 'Editar'
    fill_in 'Razão social', with: 'Asics company'
    click_on 'Enviar'
    

    expect(page).not_to have_content 'Erro ao atualizar fornecedor'
    expect(page).to have_content 'Asics company'
  end

  it 'with failed' do
    Supplier.create!(brand_name: 'Asics', corporate_name: 'Asics co', registration_number: '2345-032', 
        full_address: 'Av João Pessoa, 234', city: 'Manaus', state: 'Amazonas', email: 'asics@asics.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Asics'
    click_on 'Editar'
    fill_in 'Razão social', with: ''
    click_on 'Enviar'
    

    expect(page).to have_content 'Erro ao atualizar fornecedor'
    expect(page).to have_field 'Nome da marca', with: 'Asics'
  end
end