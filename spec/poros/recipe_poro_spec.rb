# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#initialize' do
    it 'creates a recipe from given attributes' do
      recipe_data = {
        recipe: {
          label: 'Fried Worms',
          url: 'https://example.com/fried-worms',
          image: 'https://example.com/fried-worms.jpg'
        }
      }
      country = 'USA'

      recipe = Recipe.new(recipe_data, country)

      expect(recipe.title).to eq('Fried Worms')
      expect(recipe.url).to eq('https://example.com/fried-worms')
      expect(recipe.country).to eq('USA')
      expect(recipe.image).to eq('https://example.com/fried-worms.jpg')
    end
  end
end
