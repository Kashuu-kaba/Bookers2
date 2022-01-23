class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @book = Book.new()
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new()
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new()
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "update successfully"
    else
      render :edit
    end
  end

  protected
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end