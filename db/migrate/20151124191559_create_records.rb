class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :observation_id
      t.integer :goal_id
      t.integer :result

      t.timestamps null: false
    end
  end
end
