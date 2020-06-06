# frozen_string_literal: true

class CreateBooksUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :books_users do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
