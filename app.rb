require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('pg')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

require('pry')

enable :Sessions

#TEST
get('/test') do
  @test_var = 'Sinatra OK'
  @db = "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
  erb(:test)
  #redirect to('/')
end

#INDEX redirect to recipes
get ('/') do
  redirect to('/recipes')
end

##RECIPE
#READ (list all)
get('/recipes') do
  erb(:recipes)
end

#CREATE FORM
get('/recipes/add') do
  erb(:recipe_add_form)
end
#CREATE
post('/recipes/add') do
  @recipe = Recipe.create(name: params.fetch('name'))
  redirect to("/recipes/#{@recipe.id}/edit")
end

#READ (list one in display mode)
get('/recipes/:recipe_id') do |recipe_id|
  @recipe = Recipe.find(recipe_id)
  erb(:recipe)
end

#UPDATE FORM
get('/recipes/:recipe_id/edit') do |recipe_id|
  @recipe = Recipe.find(recipe_id)
  erb(:recipe_update_form)
end
#UPDATE
patch('/recipes/:recipe_id/edit') do |recipe_id|
  instruction = params['instruction']
  Recipe.find(recipe_id).update({ :instruction => instruction})
  redirect to("/recipes/#{recipe_id}/edit")
end

##CATEGORY
#READ (list all)
get('/categories') do
  erb(:categories)
end

#CREATE (new category and redirect back to recipe update page)
post('/recipes/:recipe_id/categories/create') do |recipe_id|
  Category.create(name: params['name'])
  redirect to("/recipes/#{recipe_id}/edit")
end

#CREATE JOIN (link a category to a recipe)
post('/recipes/:recipe_id/add_category') do |recipe_id|
  recipe = Recipe.find(recipe_id)
  category = Category.find(params['category_id'])
  recipe.categories.push(category)
  redirect to("/recipes/#{recipe_id}/edit")
end


##############
##INGREDIENTS
#READ (list all)
get('/ingredients') do
  erb(:ingredients)
end

#CREATE (new ingredient and redirect back to recipe update page)
post('/recipes/:recipe_id/ingredients/create') do |recipe_id|
  Ingredient.create(name: params['name'])
  redirect to("/recipes/#{recipe_id}/edit")
end

#CREATE JOIN (link a category to an ingredient)
post('/recipes/:recipe_id/add_ingredient') do |recipe_id|
  recipe = Recipe.find(recipe_id)
  ingredient = Ingredient.find(params['ingredient_id'])
  recipe.ingredients.push(ingredient)
  redirect to("/recipes/#{recipe_id}/edit")
end
