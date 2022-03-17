class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
    if @book.save
      flash[:success] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id]) #@book = Book.findは'一つの'レコードを取り出す動作
    if @book.update(book_params) #取り出したレコードを編集してデータベースに保存し直す
      flash[:success] = "Book was successfully updated."
      redirect_to book_path(@book.id) #show（今回取り出したレコード）ページに飛ばす
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end