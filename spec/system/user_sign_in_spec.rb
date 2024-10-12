require 'rails_helper'

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
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'user@gmail.com'
    end

  end

  it 'and do logout' do
    User.create!(email: 'user@gmail.com', password: 'senha123')

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail', with: 'user@gmail.com'
      fill_in 'Senha', with: 'senha123'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    within('nav') do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'user@gmail.com'
    end
  end
end