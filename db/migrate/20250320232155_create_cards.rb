class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :attack
      t.integer :defense
      t.text :ability
      t.string :image_url

      t.timestamps
    end
  end
end
