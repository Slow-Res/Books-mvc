class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name , presence: true , uniqueness: true
  has_many :books


  filterrific(
    default_filter_params: { sorted_by: 'name asc' },
    available_filters: [
      :sorted_by,
      :search_query,
    ]
  )

  scope :search_query, lambda { |query|
  where("name LIKE  :keyword", keyword: "%#{query}%")
}



  scope :sorted_by, ->(sort_option) {
    direction = sort_option =~ /desc$/ ? 'desc' : 'asc'
    case sort_option.to_s
    when /^name/
      order("authors.name #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }


  def self.options_for_sorted_by(sort_option = nil)
    [
      ['Book name (A-Z)', 'name_asc'],
      ['Book name (Z-A)', 'name_desc'],

    ]
  end




end
