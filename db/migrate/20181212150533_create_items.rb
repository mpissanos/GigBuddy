class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :brand
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
