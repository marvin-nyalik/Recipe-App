require 'rails_helper'

RSpec.describe 'Recipe management', type: :feature do
  # before(:each) do
  #   DatabaseCleaner.clean
  # end

  before(:each) do
    user = FactoryBot.create(:user)
    user.confirm

    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
    sleep(0.05)
  end

  it 'allows a user to create a recipe' do
    visit new_recipe_path
  
    fill_in 'recipe[name]', with: 'Apple Pie'
    fill_in 'recipe[preparation_time]', with: 2
    fill_in 'recipe[cooking_time]', with: 2
    fill_in 'recipe[description]', with: 'Pie with apples'
  
    click_button 'Create Recipe'
    sleep(0.05)
    expect(page).to have_text('Recipe was successfully created.')
    expect(page).to have_text('Welcome To Recipe Page')
    expect(page).to have_text('Apple Pie')
    expect(page).to have_text('Description: Pie with apples')
  end
  
  it 'allows a user to remove a recipe' do
    visit new_recipe_path
  
    fill_in 'recipe[name]', with: 'Apple Pie'
    fill_in 'recipe[preparation_time]', with: 2
    fill_in 'recipe[cooking_time]', with: 2
    fill_in 'recipe[description]', with: 'Pie with apples'
  
    click_button 'Create Recipe'
    sleep(0.05)
    visit recipes_path
    expect(page).to have_text('Apple Pie')

    within('form') do
      click_button 'Remove'
    end
    expect(page).not_to have_text('Apple Pie')
  end
end