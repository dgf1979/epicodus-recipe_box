# ENV['RACK_ENV'] = 'test'
# require('capybara/rspec')
# require('./app')
# require('spec_helper')
#
#
# Capybara.app = Sinatra::Application
# set(:show_exceptions, false)
#
#
# describe('Sinatra framework check', { :type => :feature }) do
#   it('verifies basic routing and view setup') do
#     visit('/test')
#     expect(page).to have_content('Sinatra OK')
#   end
# end
#
# describe('Application Testing', { :type => :feature }) do
#
#   #RECIPE
#   describe('Recipe Methods') do
#     #READ (list all)
#     it('lists any added recipes') do
#       Recipe.create(name: 'Oatmeal Cookies')
#       visit('/recipes')
#       expect(page).to have_content('Oatmeal Cookies')
#     end
#
#     # #CREATE (add a new recipe)
#     # it('adds a new recipe') do
#     #   visit('/recipes/add')
#     #   fill_in('name', :with => 'Chocolate Cake')
#     #   click_button('Add Recipe')
#     #   expect(page).to have_content('Chocolate Cake')
#     # end
#
#   end
#
#   #CATEGORY
#   describe('Category Methods') do
#     #READ (list all)
#     it('lists any added categories') do
#       Category.create(name: 'Dessert')
#       visit('/categories')
#       expect(page).to have_content('Dessert')
#     end
#   end
#
#   #INGREDIENT
#   describe('Ingredient Methods') do
#     #READ (list all)
#     it('lists any added ingredients') do
#       Ingredient.create(name: 'eggs')
#       visit('/ingredients')
#       expect(page).to have_content('eggs')
#     end
#   end
# end
