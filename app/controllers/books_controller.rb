class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}


  def show
    @newBook = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @user_show = @book.user
  end

  def index
    @books = Book.all
    @user = current_user
    @newBook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end


  def create
        @newBook = Book.new(book_params)
        @newBook.user_id = current_user.id
    if  @newBook.save
        redirect_to book_path(@newBook), notice: "You have created book successfully."
    else
        @books = Book.all
        @user = current_user
        render 'index'
    end
  end


  def update
        @book = Book.find(params[:id])
        @books = Book.all
    if  @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def   ensure_current_user
        @book = Book.find(params[:id])
    if  @book.user_id != current_user.id
        redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
