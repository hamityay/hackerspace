class AddDefaultValueToCardStatus < ActiveRecord::Migration
  def change
    change_column :cards, :status, :boolean, :default => false
  end
end
