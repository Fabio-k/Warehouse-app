require 'rails_helper'

describe 'user see supplier details' do
  it 'and see aditional information' do
    Supplier.create!(brand_name: 'Adidas', corporate_name: 'Adidas co', registration_number: '2342-343', 
        full_address: 'Av paulista, 123', city: 'São Paulo', state: 'SP', email: 'adidas@gmail.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Adidas'

    expect(page).to have_content '2342-343'
    expect(page).to have_content 'Adidas co'
    expect(page).to have_content 'adidas@gmail.com'
    expect(page).to have_content 'Av paulista, 123 - São Paulo - SP'
  end

  it 'and return to supplier index' do
    Supplier.create!(brand_name: 'Adidas', corporate_name: 'Adidas co', registration_number: '2342-343', 
        full_address: 'Av paulista, 123', city: 'São Paulo', state: 'SP', email: 'adidas@gmail.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Adidas'
    click_on 'Voltar'

    expect(current_path).to eq suppliers_path
  end
end