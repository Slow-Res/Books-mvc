class BooksController < ApplicationController

  before_action :authenticate_author! ,  except: [:index ]



  # ============ Views =================

  #  def index
  #    @books = Book.all
  #    @filterrific = initialize_filterrific(
  #     Book,
  #     params[:filterrific]
  #   ) or return
  #   @books = @filterrific.find.page(params[:page])

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  #  end

  # def index
  #   permitted_params = if params.key?(:filterrific)
  #     params.require(:filterrific).permit(:sorted_by)
  #   else
  #     {}
  #   end

  #   @filterrific = initialize_filterrific(
  #     Book,
  #     permitted_params,

  #   )

  #   sorting_param = params[:filterrific] ? params[:filterrific][:sorted_by] : 'name_desc'

  #   sorting_criteria = {
  #     'name_asc' => "name+ASC",
  #     'name_desc' => "name+DESC",
  #     'release_date_asc' => 'relase_date+ASC',
  #     'release_date_desc' => 'relase_date+DESC'
  #   }
  #   sort_by =  sorting_criteria[sorting_param]




  #   books = Book.arel_table
  #   field , direction =  sort_by.split('+')
  #   puts field
  #   puts direction
  #   puts @filterrific.find.order("books"."name")
  #   @books =  Book.all



  # end



  def index

    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      select_options: {
        sorted_by: Book.options_for_sorted_by,
      }
    )

    sorting_param = params[:filterrific] ? params[:filterrific][:sorted_by] : 'name_desc'

    sorting_criteria = {
      'name_asc' => "name ASC",
      'name_desc' => "name DESC",
      'release_date_asc' => 'relase_date ASC',
      'release_date_desc' => 'relase_date DESC'
    }

    sort_by =  sorting_criteria[sorting_param]
    @books = @filterrific.find.order( sort_by)

    puts @books.inspect

  end

  # def index
  #   @filterrific = initialize_filterrific(Book, params[:filterrific]) do |scope|
  #     scope.search_query(params[:filterrific][:search_query])
  #     scope.sorted_by(params[:filterrific][:sorted_by])
  #   end
  #   @books = @filterrific.try(:find) || Book.all
  # end

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
