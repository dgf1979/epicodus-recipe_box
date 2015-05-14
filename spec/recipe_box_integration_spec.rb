require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Sinatra framework check', { :type => :feature }) do
 it('verifies basic routing and view setup') do
   visit('/test')
   expect(page).to have_content('Sinatra OK')
 end
end

describe('Application Testing:', { :type => :feature }) do

  #RECIPE
  describe('Recipe Methods:') do
   #READ (list all)
   it('lists any added recipes') do
     Recipe.create(name: 'Oatmeal Cookies')
     visit('/recipes')
     #save_and_open_page
     expect(page).to have_content('Oatmeal Cookies')
   end

   #READ (list one)
   it('dsiplays a single recipe card') do
     recipe = Recipe.create(name: 'cassarole')
     visit("/recipes/#{recipe.id}")
     expect(page).to have_content('Cassarole')
   end

   #UPDATE (edit recipe)
   it('displays edit form with instantaneous results') do
     recipe = Recipe.create(name: 'Sandwich')
     visit("/recipes/#{recipe.id}/edit")
     find_field('rating').value
   end
  end

  #CATEGORY
  describe('Category Methods:') do
   #READ (list all)
   it('lists any added categories') do
     Category.create(name: 'Dessert')
     visit('/categories')
     expect(page).to have_content('DESSERT')
   end

   #DELETE (delete a single category)
   it('removes a category') do
     category = Category.create(name: 'Dessert')
     visit('/categories')
     find(:xpath, "//a[@href='/categories/#{category.id}/delete']").click
     expect(page).to_not have_content('DESSERT')
   end
  end

  #INGREDIENT
  describe('Ingredient Methods:') do
   #READ (list all)
   it('lists any added ingredients') do
     Ingredient.create(name: 'eggs')
     visit('/ingredients')
     expect(page).to have_content('eggs')
   end
  end
end
