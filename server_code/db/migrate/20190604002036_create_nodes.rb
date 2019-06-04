class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :host_identifier, null: false
      t.string :key, null: false
      t.json :configuration
      t.references :customer, foreign_key: true
      t.timestamps null: false
    end

    add_index :nodes, :host_identifier, unique: true
  end
end
