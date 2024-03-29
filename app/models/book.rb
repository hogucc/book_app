# frozen_string_literal: true

class Book < ApplicationRecord
  include Commentable
  mount_uploader :picture, PictureUploader
  paginates_per 5
  has_and_belongs_to_many :users
end
