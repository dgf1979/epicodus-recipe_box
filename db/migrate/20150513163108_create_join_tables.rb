class CreateJoinTables < ActiveRecord::Migration
  def change
    create_table(:categories_recipes) do |t|
      t.column(:recipe_id, :int)
      t.column(:category_id, :int)
      t.timestamps
    end
    create_table(:ingredients_recipes) do |t|
      t.column(:recipe_id, :int)
      t.column(:ingredient_id, :int)
      t.timestamps
    end
  end
end
