require 'rails_helper'

describe 'user regiter supplier ' do 
  it 'fron the supplier index' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    expect(page).to have_field 'Nome da marca'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
  end

  it 'with success' do

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    fill_in 'Nome da marca', with: 'Apple'
    fill_in 'Razão social', with: 'Apple Co'
    fill_in 'CNPJ', with: '0439-234'
    fill_in 'Endereço', with: 'st. petersburg, 101'
    fill_in 'Cidade',  with: 'California'
    fill_in 'Estado', with: 'California'
    click_on 'Cadastrar'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Apple'
  end
end