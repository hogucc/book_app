# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :self_introduction, length: { maximum: 200 }
  validates :postal_code, length: { is: 7 }
  has_and_belongs_to_many :books
end
