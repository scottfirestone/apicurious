class ChangeColumnsInUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :spotify, :string
    add_column :users, :image, :string
    add_column :users, :token, :string
    add_column :users, :refresh_token, :string

    remove_column :users, :password_digest
  end
end
