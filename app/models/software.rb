class Software < ApplicationRecord
  validates :name, :type, :description, :image, presence: true  
end
