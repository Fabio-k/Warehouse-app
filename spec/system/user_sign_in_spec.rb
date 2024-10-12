describe 'user sign in' do
  it 'with success' do
    User.create!(email: 'user@gmail.com', password: 'senha123')


    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail', with: 'user@gmail.com'
      fill_in 'Senha', with: 'senha123'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_link 'Sair'
      expect(page).to have_content 'user@gmail.com'
    end

  end
end