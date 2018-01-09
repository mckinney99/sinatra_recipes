class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
  	create_table :recipes do |t|
  		t.string :name
  		t.string :ingredients
  		t.string :instructions
  		t.integer :user_id
  	end
  end
end