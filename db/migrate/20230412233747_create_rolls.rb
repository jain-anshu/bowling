class CreateRolls < ActiveRecord::Migration[7.0]
  def change
    create_table :rolls do |t|
      t.string :value, null: false
      t.integer :numeric_value, default: 0
      t.boolean :pending1, default: false
      t.boolean :pending2, default: false
      t.boolean :is_last, default: false
      t.integer :total, default: 0
      t.references :frame, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end