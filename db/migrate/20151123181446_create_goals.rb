class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :student_id
      t.string :text
      t.string :prompt
      t.string :meme

      t.timestamps null: false
    end
  end
end