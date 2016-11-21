class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :remote_id,     null: false
      t.string  :name,          null: false
      t.decimal :price,         null: false, precision: 8, scale: 2
      t.json    :details,       null: false, default: []
      t.json    :reviews,       null: false, default: []

      t.timestamps
    end

    add_index :products, :remote_id, unique: true
  end
end
