class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 2, maximum: 150 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :user_id, presence: true
 
  
end