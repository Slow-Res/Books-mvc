require 'csv'
class Book < ApplicationRecord
  belongs_to :author
  validates :name , presence: true , uniqueness: true
  validates :relase_date , presence: true
  validate :validate_relase_date


  filterrific(
    default_filter_params: { sorted_by: 'name asc' },
    available_filters: [
      :sorted_by,
      :search_query,
    ]
  )



  scope :search_query, lambda { |query|
  where("name LIKE  :keyword", keyword: "%#{query}%")
  .or(where("relase_date LIKE  :keyword", keyword: "%#{query}%"))
}



    scope :sorted_by, ->(sort_option) {
      direction = sort_option =~ /desc$/ ? 'desc' : 'asc'
      case sort_option.to_s
      when /^release_date_/
        order("books.created_at #{direction}")
      when /^name_/
        order("books.name #{direction}")
      else
        raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
      end
    }

    def self.options_for_sorted_by(sort_option = nil)
      [
        ['Book name (A-Z)', 'name_asc'],
        ['Book name (Z-A)', 'name_desc'],
        ['Release  date (Newest first)', 'release_date_desc'],
        ['Release  date (Oldest first)', 'release_date_asc']
      ]
    end



  def validate_relase_date
    if self.relase_date.present?
      isFuture =  self.relase_date > Time.now
        if isFuture == true
          errors.add(:relase_date, "Invalid publish date ")
        end
    end
  end

  def self.to_csv
    attributes = %w(id name relase_date author_name) # Customize columns here

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |book|
        csv << [
          book.id,
          book.name,
          book.relase_date,
          book.author.name
        ]
      end
    end
  end

end
