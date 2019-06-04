class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :enrollment_secret, null: false
      t.timestamps null: false
    end

    add_index :customers, :enrollment_secret, unique: true
  end
end
