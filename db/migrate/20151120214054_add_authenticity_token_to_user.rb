class AddAuthenticityTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authenticity_token, :string
  end
end
