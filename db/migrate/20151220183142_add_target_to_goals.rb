class AddTargetToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :target, :integer
  end
end
