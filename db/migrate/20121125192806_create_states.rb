class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :iso
      t.string :name
      t.references :country

      t.timestamps
    end
  end
end
