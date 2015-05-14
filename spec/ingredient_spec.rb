require('spec_helper')

describe(Ingredient) do
  describe('Validations and Callbacks') do
    it('ensures ingredient name is present and unique') do
      Ingredient.create(name: 'salt')
      Ingredient.create(name: 'salt')
      Ingredient.create(name: '')
      expect(Ingredient.all.length).to(eq(1))
    end

    it('ensures words in ingrdient name are downcase') do
      ingredient = Ingredient.create(name: 'Baking Soda')
      expect(ingredient.name).to(eq('baking soda'))
    end
  end
end
