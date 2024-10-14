describe 'user register product model' do
  it 'with success' do
    user = User.create!(name: 'fabio', email: 'fabio@gmail.com', password: 'senha123')
    

    Supplier.create!(brand_name: 'Apple', corporate_name:'Apple Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av Brasil, 340', city: 'São Paulo', state: 'SP', email: 'apple@apple.com')
    Supplier.create!(brand_name: 'Samsung', corporate_name:'Samsung Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av nações unidas, 100', city: 'São Paulo', state: 'SP', email: 'samsung@samsung.com')

    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: 'Macbook pro m3'
    fill_in 'Peso', with: 1800
    fill_in 'Altura', with: 2
    fill_in 'Largura', with: 30
    fill_in 'Profundidade', with: 21
    fill_in 'SKU', with: 'MBOK-APPLE-M3'
    select 'Apple', from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).not_to have_content 'Erro ao cadastrar modelo de produto'
    expect(page).to have_content 'Modelo de produto salvo com sucesso'
    expect(page).to have_content 'Macbook pro m3'
    expect(page).to have_content 'Peso: 1800g'
    expect(page).to have_content 'Dimensões: 2cm x 30cm x 21cm'
    expect(page).to have_content 'SKU: MBOK-APPLE-M3'
    expect(page).to have_content 'Fornecedor: Apple'
    
  end

  it 'with incomplete data' do
    user = User.create!(name: 'fabio', email: 'fabio@gmail.com', password: 'senha123')
    Supplier.create!(brand_name: 'Apple', corporate_name:'Apple Electronics Ltda', registration_number: '1324-432', 
        full_address: 'Av Brasil, 340', city: 'São Paulo', state: 'SP', email: 'apple@apple.com')
    
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar modelo de produto'

    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Erro ao cadastrar modelo de produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
  end
end