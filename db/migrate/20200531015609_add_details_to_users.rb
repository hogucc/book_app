# frozen_string_literal: true

class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string, null: false
    add_column :users, :postal_code, :string
    add_column :users, :address, :string
    add_column :users, :self_introduction, :text
  end
end
