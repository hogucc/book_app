# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user  = User.find(params[:user_id])
    @users = @user.followers
  end
end
