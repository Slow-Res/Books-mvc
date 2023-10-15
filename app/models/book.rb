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

end
