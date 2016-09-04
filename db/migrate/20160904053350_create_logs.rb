class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :enter_time
      t.datetime :exit_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
