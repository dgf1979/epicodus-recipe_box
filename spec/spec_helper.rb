ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require('pry')

#ActiveRecord::Base.establish_connection(:test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file}

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "*******************"
puts "RACK_ENV: #{ENV['RACK_ENV']} "
puts "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
puts "*******************"

RSpec.configure do |config|
  config.before(:each) do
    #optionally do something before each test
  end
  config.after(:each) do
    #optionally do something after each test
    Category.all.each do |c|
      c.destroy()
    end
    Ingredient.all.each do |i|
      i.destroy()
    end
    Recipe.all.each do |r|
      r.destroy()
    end
  end
end
