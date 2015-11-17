class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
