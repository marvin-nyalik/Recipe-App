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
    sleep(1)
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

  it 'allows user to add food to a Recipe' do
    visit new_food_path
    fill_in 'name', with: 'Apple'
    fill_in 'measurement_unit', with: 'Grams'
    fill_in 'price', with: 10
    click_button 'Add Food'

    expect(page).to have_text('Food successfully added')
    sleep(1)

    visit new_recipe_path

    fill_in 'recipe[name]', with: 'Apple Pie'
    fill_in 'recipe[preparation_time]', with: 2
    fill_in 'recipe[cooking_time]', with: 2
    fill_in 'recipe[description]', with: 'Pie with apples'

    click_button 'Create Recipe'
    sleep(0.05)
    expect(page).to have_text('Recipe was successfully created.')

    sleep(0.5)
    visit recipes_path

    click_link 'Apple Pie'
    sleep(1)
    click_link 'Add Ingredient'
    sleep(2)
    select Food.first.name, from: 'recipe_food[food_id]'

    fill_in 'recipe_food[quantity]', with: 5 # Change 'quantity' to the actual name of your quantity field

    within('form') do
      click_button 'Create Recipe Food'
    end

    sleep(1)
    expect(page).to have_text('Recipe Food was successfully created')
    sleep(3)
  end
end
