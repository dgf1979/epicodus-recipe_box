require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

#TEST
get('/test') do
  @test_var = 'Sinatra OK'
  @db = "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
  erb(:test)
  #redirect to('/')
end

#INDEX
get ('/') do
  erb(:index)
end

##RECIPE
#READ (list all)
get('/recipes') do
  erb(:recipes)
end

##CATEGORY
#READ (list all)
get('/categories') do
  erb(:categories)
end

##INGREDIENTS
#READ (list all)
get('/ingredients') do
  erb(:ingredients)
end
