class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards, id: false do |t|
      t.string :card_id, null: false
      t.string :card_no
      t.boolean :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :cards, :card_id, unique: true
  end
end
