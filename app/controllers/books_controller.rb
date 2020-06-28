# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_current_user_book, only: [:edit, :update, :destroy]

  # GET /books
  def index
    @books = Book.all.order(:title).page(params[:page])
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])
    @user_id = @book.users.first.id
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.build(book_params)

    if @book.save
      current_user.books << @book
      redirect_to @book, notice: t("books.created.notice")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("books.updated.notice")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t("books.deleted.notice")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user_book
      @book = current_user.books.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
