require 'rails_helper'

describe 'user registers warehouse' do
  it 'from the homepage' do
    visit root_path
    click_on 'Cadastrar Galpão'

    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Descrição')
  end

  it 'with success' do
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: "Rio de Janeiro"
    fill_in 'Código', with: "RIO"
    fill_in 'Cidade', with: "Rio de Janeiro"
    fill_in 'Área', with: "32000"
    fill_in 'Endereço', with: "Avenida do Museu do Amanhã, 1000"
    fill_in 'CEP', with: "20100-000"
    fill_in 'Descrição', with: "Galpão da zona portuária do Rio"

    click_on 'Enviar'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso.'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO' 
  end

  it 'with incomplete data' do
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''  
    fill_in 'Descrição', with: ''  
    fill_in 'Código', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
  end
end