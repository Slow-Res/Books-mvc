class BooksController < ApplicationController
  before_action :set_rss , only: [:edit, :update, :show, :destroy]
  before_action :authenticate_author! ,  except: [:index ]



  # ============ Views =================

 def index

 end

 def new

 end

 def show

 end

 def edit

 end

 # ============ CREATE - UPDATE -  DELETE =================

 def create

 end

 def update

 end

 def destroy

 end

 def json_data

 end


 private

 def rss_params

 end

 def set_rss

 end




end
