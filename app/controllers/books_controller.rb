class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy borrow return_book]

  # GET /books
  def index
    @books = Book.all
  end

  # GET /books/1
  def show
    @borrower = User.find_by(book_id: @book.id, returned_on: nil) # Find current borrower if exists
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy!
    redirect_to books_path, notice: "Book was successfully destroyed.", status: :see_other
  end

  # Borrow a book
  def borrow
    if @book.status == "Available"
      user = User.new(
        name: params[:name],
        id_number: params[:id_number],
        phone_number: params[:phone_number],
        email: params[:email],
        book_id: @book.id,
        borrowed_on: Date.today,
        returned_on: nil
      )

      if user.save
        @book.update!(status: "Borrowed") # ✅ Ensures book status updates only if user is saved
        redirect_to @book, notice: "Book successfully borrowed."
      else
        redirect_to @book, alert: "Error borrowing book. Please try again."
      end
    else
      redirect_to @book, alert: "Book is not available for borrowing."
    end
  end

  # Return a book
  def return_book
    user = User.find_by(book_id: @book.id, returned_on: nil)

    if user
      user.update!(returned_on: Date.today) # ✅ Marks book as returned
      @book.update!(status: "Available") # ✅ Updates book status
      redirect_to @book, notice: "Book successfully returned."
    else
      redirect_to @book, alert: "No active borrow record found for this book."
    end
  end

  private

  # Use callbacks to share common setup
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow trusted parameters
  def book_params
    params.require(:book).permit(:title, :author, :genre, :published_date, :status)
  end
end
