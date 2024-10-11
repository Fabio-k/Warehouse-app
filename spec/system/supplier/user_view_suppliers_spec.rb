describe 'user visit suppliers' do
  it 'with success' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
  end

  it 'and see the listed suppliers' do
    Supplier.create!(brand_name: 'Adidas', corporate_name: 'Adidas co', registration_number: '2342-343', full_address: 'Av paulista, 123', city: 'São Paulo', state: 'SP', email: 'adidas@gmail.com')

    visit root_path
    click_on 'Fornecedores'
    
    expect(page).not_to have_content('Nenhum fornecedor cadastrado')

    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Adidas')
    expect(page).to have_content('São Paulo - SP')
  end

  it 'and there are no suppliers registered' do
    visit root_path
    click_on 'Fornecedores'
    
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Nenhum fornecedor cadastrado')
  end
end