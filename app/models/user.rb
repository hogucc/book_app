# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable, :omniauthable, omniauth_providers: %i(github)
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :self_introduction, length: { maximum: 200 }
  has_and_belongs_to_many :books
  has_one_attached :avatar
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.user_name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
