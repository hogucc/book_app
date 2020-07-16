# frozen_string_literal: true

class AddCommentableRefToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :commentable, polymorphic: true, null: false
  end
end
