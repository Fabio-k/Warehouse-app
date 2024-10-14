require 'rails_helper'

describe 'user authenticate' do
  it 'with success' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'fabio@gmail.com'
    fill_in 'Senha', with: 'senha123'
    fill_in 'Confirme sua senha', with: 'senha123'
    fill_in 'Nome', with: 'Fabio'
    within 'form' do
      click_on 'Criar conta'
    end

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    within('nav') do
      expect(page).to have_content 'Sair'
      #expect(page).to have_content 'Olá Fabio'
      expect(page).to have_content 'fabio@gmail.com'
      user = User.last 
      expect(user.name).to eq 'Fabio'
    end
  end
end