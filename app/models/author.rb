class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name , presence: true , uniqueness: true
  validates :email , presence: true , uniqueness: true
  validates :password , presence: true , length: { minimum: 6 } , on: :create
  validates :password , length: { minimum: 6 } , allow_blank: true , on: :update
  has_many :books


  filterrific(
    default_filter_params: { sorted_by: 'name_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
    ]
  )

  scope :search_query, lambda { |query|
  where("name LIKE  :keyword", keyword: "%#{query}%")
}



  scope :sorted_by, ->(sort_option) {


  sorting_criteria = {
    'name_asc' => "name ASC",
    'name_desc' => "name DESC",
  }

  sort_by =  sorting_criteria[sort_option]
  order(sort_by)


  }


  def self.options_for_sorted_by(sort_option = nil)
    [
      ['Book name (A-Z)', 'name_asc'],
      ['Book name (Z-A)', 'name_desc'],

    ]
  end




end
