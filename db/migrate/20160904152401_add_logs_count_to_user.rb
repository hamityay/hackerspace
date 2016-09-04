class AddLogsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :logs_count, :integer
  end
end
