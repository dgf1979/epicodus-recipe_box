require("bundler/setup")
Bundler.require(:default, :production)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

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
  update_hash = Hash.new()
  if params.has_key?('name')
    update_hash.store(:name, params['name'])
  end
  if params.has_key?('instruction')
    update_hash.store(:instruction, params['instruction'])
  end
  if params.has_key?('rating')
    update_hash.store(:rating, params['rating'].to_i)
  end
  if !update_hash.empty?
    Recipe.find(recipe_id).update(update_hash)
  end
  redirect to("/recipes/#{recipe_id}")
end

# #DELETE
# delete('/recipes/:recipe_id/delete') do |recipe_id|
#   Recipe.find(recipe_id).destroy
#   redirect to('/recipes')
# end

#DELETE
get('/recipes/:recipe_id/delete') do |recipe_id|
  Recipe.find(recipe_id).destroy
  redirect to('/recipes')
end

##CATEGORY
#READ (list all)
get('/categories') do
  erb(:categories)
end

#READ (list RECIPES using)
get('/categories/:category_id/recipes') do |category_id|
  @category = Category.find(category_id)
  @recipes = @category.recipes
  erb(:recipes_with_category)
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

#DELETE JOIN
get('/recipes/:recipe_id/remove_category/:category_id') do |recipe_id, category_id|
  recipe = Recipe.find(recipe_id)
  category = Category.find(category_id)
  recipe.categories.destroy(category)
  redirect to("/recipes/#{recipe_id}/edit")
end

##############
##INGREDIENTS
#READ (list all)
get('/ingredients') do
  erb(:ingredients)
end

#READ (list RECIPES using)
get('/ingredients/:ingredient_id/recipes') do |ingredient_id|
  @ingredient = Ingredient.find(ingredient_id)
  @recipes = @ingredient.recipes
  erb(:recipes_using_ingredient)
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

#DELETE JOIN
get('/recipes/:recipe_id/remove_ingredient/:category_id') do |recipe_id, ingredient_id|
  recipe = Recipe.find(recipe_id)
  ingredient = Ingredient.find(ingredient_id)
  recipe.ingredients.destroy(ingredient)
  redirect to("/recipes/#{recipe_id}/edit")
end
