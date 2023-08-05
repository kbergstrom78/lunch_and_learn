require 'rails_helper'

describe RecipesFacade do
  describe '.get_recipes' do
    it 'returns recipes for a given country', :vcr do
      country = 'Spain'
      recipes = RecipesFacade.get_recipes(country)

      expect(recipes).to be_an(Array)
      expect(recipes.first).to be_a(Recipe)
      expect(recipes.first.title).to be_a(String)
    end

    it 'handles an empty response', :vcr do
      country = ''
      recipes = RecipesFacade.get_recipes(country)

      expect(recipes).to be_an(Array)
      expect(recipes).to be_empty
    end
  end
end
