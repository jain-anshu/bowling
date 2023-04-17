class CreateFrames < ActiveRecord::Migration[7.0]
  def change
    create_table :frames do |t|
      t.boolean :is_last, default: false
      t.timestamps
    end
  end
end
