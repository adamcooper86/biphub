class ChangeEndToFinishBips < ActiveRecord::Migration
  def change
    rename_column :bips, :end, :finish
  end
end
