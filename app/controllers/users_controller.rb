# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @following_count = @user.following.count
    @followers_count = @users = @user.followers.count
  end

  def index
    @users = User.all
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.fetch(:user, {}).permit(:user_name, :email, :postal_code, :address, :self_introduction, :avatar)
    end
end
