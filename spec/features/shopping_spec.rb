require 'rails_helper'

RSpec.describe 'Shopping list generator ', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    user.confirm

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password123'
    click_button 'Log in'
    sleep(1)
    expect(page).to have_content('Signed in successfully.')
  end

  it 'appropriately generates a shopping list' do
    visit new_food_path
    fill_in 'name', with: 'Apple'
    fill_in 'measurement_unit', with: 'Grams'
    fill_in 'price', with: 10
    click_button 'Add Food'

    expect(page).to have_text('Food successfully added')
    sleep(1)

    visit new_inventory_path

    fill_in 'name', with: 'Inventory 1'
    fill_in 'description', with: 'Invent 1 desc'
    click_button 'Create Inventory'
    sleep(0.5)
    expect(page).to have_text('Inventory successfully added')
    sleep(0.5)
    visit new_recipe_path
    fill_in 'recipe[name]', with: 'Apple Pie'
    fill_in 'recipe[preparation_time]', with: 2
    fill_in 'recipe[cooking_time]', with: 2
    fill_in 'recipe[description]', with: 'Pie with apples'

    click_button 'Create Recipe'
    expect(page).to have_text('Recipe was successfully created.')
    sleep(0.5)

    click_link 'Apple Pie'
    sleep(1)
    click_button 'Generate shopping list'

    sleep(1)
    select(Inventory.first.name, from: 'Inventory')
    click_button 'Generate'
    sleep(3)
    expect(page).to have_text('Shopping List')
  end
end
