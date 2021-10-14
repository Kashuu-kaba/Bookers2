class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.new()
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "create successfully"
    else
      @books = Book.all
      render "index"
    end
  end

  def show
    @book_new = Book.new()
    @book = Book.find(params[:id])
    @book_comment = BookComment.new()
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book.user_id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "update successfully"
    else
      render book_path(@book)
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  protected
  def create_params
    params.permit(:title,:body)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
