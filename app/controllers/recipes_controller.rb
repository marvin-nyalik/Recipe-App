class RecipesController < ApplicationController
  def index
    @user = current_user
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to recipes_path
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true)
  end
end
