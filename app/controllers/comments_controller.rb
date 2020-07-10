# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t("comments.created.notice")
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t("comments.updated.notice")
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t("comments.deleted.notice")
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
