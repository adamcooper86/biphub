class AddSpeducatorIdToStudent < ActiveRecord::Migration
  def change
    add_column :students, :speducator_id, :integer
  end
end
