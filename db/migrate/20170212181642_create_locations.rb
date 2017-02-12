class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :review_id, :integer, { default: false } 
   end
  end
