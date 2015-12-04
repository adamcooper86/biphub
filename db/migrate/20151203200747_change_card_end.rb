class ChangeCardEnd < ActiveRecord::Migration
  def change
    rename_column :cards, :end, :finish
  end
end
