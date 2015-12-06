class CreateBips < ActiveRecord::Migration
  def change
    create_table :bips do |t|
      t.integer :student_id
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
