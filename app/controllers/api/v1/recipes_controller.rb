class Api::V1::RecipesController < ApplicationController
  skip_before_action :authenticate_request, only: [:search]
  def search
    country = CountryFacade.get_country(params[:country])
    recipes = RecipesFacade.get_recipes(country)
    render json: RecipeSerializer.new(recipes)
  end
end