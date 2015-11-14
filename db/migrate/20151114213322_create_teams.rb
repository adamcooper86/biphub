class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :student_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
