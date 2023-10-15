class AuthorsController < ApplicationController



  # def index
  #   @authors = Author.all

  #   render 'authors_data/index'
  # end


  def index
    permitted_params = if params.key?(:filterrific)
      params.require(:filterrific).permit(:sorted_by)
    else
      {}
    end

    @filterrific = initialize_filterrific(
      Author,
      permitted_params
    )

    sorting_param = params[:filterrific] ? params[:filterrific][:sorted_by] : 'name desc'

    @authors = @filterrific.find.order(sorting_param) # Use 'order' to sort the results

    puts @authors.inspect

    render 'authors_data/index'
  end







end
