class AddRaceToStudents < ActiveRecord::Migration
  def change
    add_column :students, :race, :integer
  end
end
