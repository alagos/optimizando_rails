class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "states", "countries", :name => "states_country_id_fk"
  end
end
