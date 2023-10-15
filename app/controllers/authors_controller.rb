class AuthorsController < ApplicationController



  def index
    @authors = Author.all

    render 'authors_data/index'
  end







end
