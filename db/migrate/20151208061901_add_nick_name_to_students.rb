class AddNickNameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :alias, :string
  end
end
