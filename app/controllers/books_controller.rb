class BooksController < ApplicationController

  before_action :authenticate_author! ,  except: [:index ]



  # ============ Views =================

  def books
    @books = current_author.books
    render 'books/books'
  end

 def index
   @books = Book.all
 end

 def new

  @book = current_author.books.new

 end

 def show

  @book = current_author.books.find(params[:id])


 end

 def edit
  @book = current_author.books.find(params[:id])

 end

 # ============ CREATE - UPDATE -  DELETE =================

 def download
    @books = Book.all
    send_data @books.to_csv, filename: "books-#{Date.today}.csv"
 end

 def create

  @book = current_author.books.new(book_params)
  if @book.save
    puts "Created Sucessfully"
    redirect_to books_path , notice: "Your books was published successfully"
  else
    render :new
  end

 end

 def update
  @book = current_author.books.find(params[:id])
  if @book.update(book_params)
    redirect_to books_path(@book) , notice: "Books has been updated sucessfully"
  else
    render :edit
  end

 end

 def destroy
  @book = current_author.books.find(params[:id])
  @book.destroy
  redirect_to author_books_path , notice: "Book has been deleted sucessfully"

 end

 def json_data

 end


 private

 def book_params
  params.require(:book).permit(:name , :relase_date)
 end






end
