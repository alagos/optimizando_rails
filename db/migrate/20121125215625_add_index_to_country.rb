class AddIndexToCountry < ActiveRecord::Migration
  def change
    add_index :countries, [:name]
    add_index :states, [:name]
    add_index :states, [:country_id]
    add_index :states, [:country_id, :name]
  end
end
