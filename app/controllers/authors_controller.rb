class AuthorsController < ApplicationController



  # def index
  #   @authors = Author.all

  #   render 'authors_data/index'
  # end


  def index



    @filterrific = initialize_filterrific(
      Author,
      params[:filterrific],
      select_options: {
        sorted_by: Author.options_for_sorted_by,
      }
    )

    sorting_param = params[:filterrific] ? params[:filterrific][:sorted_by] : 'name_asc'

    sorting_criteria = {
      'name_asc' => "name ASC",
      'name_desc' => "name DESC",
    }

    sort_by =  sorting_criteria[sorting_param]
    @authors = @filterrific.find.order(sort_by)

    puts @authors.inspect



    render 'authors_data/index'
  end







end
