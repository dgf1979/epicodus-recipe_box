ENV['RACK_ENV'] = 'test'
require('spec_helper')

describe(Recipe) do
  describe('Associations with Ingredients and Categories') do
    it('adds and verifies adding a category to a recipe') do
      recipe = Recipe.create(name: 'Cookies')
      category = recipe.categories.create(name: 'Dessert')
      expect(recipe.categories.find(category.id).name).to(eq('Dessert'))
    end
  end
end
