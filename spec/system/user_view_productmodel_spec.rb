require 'rails_helper'

describe 'user see product model' do
  it 'from the menu' do
    visit root_path

    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    
    expect(current_path).to eq product_models_path
  end

  it 'with success' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,sku: 'TV32-SAMSU-SD34', supplier: supplier)
    ProductModel.create!(name: 'Smartphone', weight: 50, width: 10, height: 35, depth: 1,sku: 'S20-SAMSU-XKS4', supplier: supplier)

    visit root_path

    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Modelos de Produtos'
    expect(page).to have_content 'Smartphone'
    expect(page).to have_content 'TV32-SAMSU-SD34'
    expect(page).to have_content 'S20-SAMSU-XKS4'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Samsung'
  end

  it 'and there aren\'t product models registered' do
    visit root_path

    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end

end