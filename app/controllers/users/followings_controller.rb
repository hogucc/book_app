# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user  = User.find(params[:user_id])
    @users = @user.following
  end
end
