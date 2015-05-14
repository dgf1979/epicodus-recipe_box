require('spec_helper')

describe(Recipe) do
  describe('Associations with Ingredients and Categories') do
    it('adds and verifies adding a category to a recipe') do
      recipe = Recipe.create(name: 'Cookies')
      category = recipe.categories.create(name: 'Dessert')
      expect(recipe.categories.find(category.id).name).to(eq('DESSERT'))
    end
  end

  describe('Validations and Callbacks') do
    it('ensures recipe name is present and unique') do
      Recipe.create(name: 'cake')
      Recipe.create(name: 'cake')
      Recipe.create(name: '')
      expect(Recipe.all.length).to(eq(1))
    end

    it('ensures words in recipe name are capitalized') do
      recipe = Recipe.create(name: 'banana split')
      expect(recipe.name).to(eq('Banana Split'))
    end
  end
end
