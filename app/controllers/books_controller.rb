class BooksController < ApplicationController

  before_action :authenticate_author! ,  except: [:index , :download ]

  def index

    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      select_options: {
        sorted_by: Book.options_for_sorted_by,
      }
    )

    @books = @filterrific.find
  end


  def books
    @books = current_author.books
    render 'books/books'
  end


 def new

  @book = current_author.books.new

 end

 def show

  if params[:id].to_i == 0
    @books = Book.all
    redirect_to "/"
    return
  end

  @book = current_author.books.find(params[:id])


 end

 def edit

  if params[:id].to_i == 0
    @books = Book.all
    redirect_to author_books_path
    return
  end

  @book = current_author.books.find(params[:id])

 end

 # ============ CREATE - UPDATE -  DELETE =================

 def download

  @filterrific = initialize_filterrific(
    Book,
    params[:filterrific],
  )

  @books = @filterrific.find
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
