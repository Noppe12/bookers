class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all.order(id: :asc)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = "Book was successfully deleted."
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      flash.now[:danger] = "Failed to update."
      render :edit
    end
  end

  def create
    @books = Book.all.order(id: :asc)
    @book = Book.new(book_params)
     if @book.save
       flash[:success] = "Book was successfully created."
       redirect_to book_path(@book.id)
     else
       render :index
     end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
