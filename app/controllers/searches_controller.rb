class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range] #検索フォームから検索するモデルの情報を受け取る
    if @range == "User" #検索するモデルをUserかBookで条件分岐させてる
      @users = User.looks(params[:search],params[:word]) #params[:search]は検索フォームから検索方法の情報を受け取る
      #looksメソッドで@usersにUserモデル内での検索結果を代入
    else                                                 #params[:word]は検索フォームから検索ワードの情報を受け取る
      @book = Book.looks(params[:search],params[:word])
      #looksメソッドで@booksにBookモデル内での検索結果を代入
    end
  end

end
