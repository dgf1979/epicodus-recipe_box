require('spec_helper')

describe(Category) do
  describe('Validations and Callbacks') do
    it('ensures category name is present and unique') do
      Category.create(name: 'dessert')
      Category.create(name: 'dessert')
      Category.create(name: '')
      expect(Category.all.length).to(eq(1))
    end

    it('ensures words in category name are upcase') do
      category = Category.create(name: 'supper')
      expect(category.name).to(eq('SUPPER'))
    end
  end
end
