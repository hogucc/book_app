# frozen_string_literal: true

class AddUserRefToReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, null: false, foreign_key: true
  end
end
