class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name , presence: true , uniqueness: true
  has_many :books



  filterrific(
    available_filters: %i[sorted_by],
  )

  scope :sorted_by, lambda { |sort_option|
  puts "+++++++++++++++++++++++++++++++++++++++"
  puts sort_option
  field, direction = sort_option.split(' ')
  puts field.length
  puts direction.length
  order("#{field} #{direction}")
  puts "+++++++++++++++++++++++++++++++++++++++"


  }

end
