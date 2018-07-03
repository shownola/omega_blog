class Article < ApplicationRecord
  
  validates :title, presence: true, length: { minimum: 2, maximum: 150 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }
  
end