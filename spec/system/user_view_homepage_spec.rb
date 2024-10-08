require 'rails_helper'

describe 'user visits homepage' do
  it 'See app name' do 
    #Arrange
    
    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end