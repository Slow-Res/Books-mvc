require 'csv'

class Book < ApplicationRecord
  belongs_to :author
  validates :name , presence: true , uniqueness: true
  validates :relase_date , presence: true
  validate :validate_relase_date

  def validate_relase_date
    if self.relase_date.present?
      isFuture =  self.relase_date > Time.now
        if isFuture == true
          errors.add(:age, "Relase Date can't be in future")
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
