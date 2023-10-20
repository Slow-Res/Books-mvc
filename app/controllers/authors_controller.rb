class AuthorsController < ApplicationController



  def index

    @filterrific = initialize_filterrific(
      Author,
      params[:filterrific],
      select_options: {
        sorted_by: Author.options_for_sorted_by,
      }
    )

    @authors = @filterrific.find
    render 'authors_data/index'

  end







end
