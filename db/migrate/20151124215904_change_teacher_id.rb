class ChangeTeacherId < ActiveRecord::Migration
  def change
    rename_column :cards, :teacher_id, :user_id
  end
end
