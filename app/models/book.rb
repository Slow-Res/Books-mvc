require 'csv'

class Book < ApplicationRecord
  belongs_to :author
  validates :name , presence: true , uniqueness: true
  validates :relase_date , presence: true
  validate :validate_relase_date

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

  def validate_relase_date
    if self.relase_date.present?
      isFuture =  self.relase_date > Time.now
        if isFuture == true
          errors.add(:relase_date, "can't be in future")
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
