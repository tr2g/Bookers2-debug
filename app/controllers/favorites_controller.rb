class FavoritesController < ApplicationController
  before_action :book_params

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #redirect_to book_path(book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_to book_path(book)
  end

  private
  def book_params
    params.require(:book_id)#.permit(:title, :body)
    #@book = Book.find(params[:id])
  end

end