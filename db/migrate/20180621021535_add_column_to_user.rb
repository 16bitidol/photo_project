class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :consumer_key, :string
    add_column :users, :consumer_secret, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end
