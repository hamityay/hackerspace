class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :bio, :text
  end
end
