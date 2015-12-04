class ChangeObservationsEndToFinish < ActiveRecord::Migration
  def change
    rename_column :observations, :end, :finish
    rename_column :observations, :teacher_id, :user_id
  end
end
