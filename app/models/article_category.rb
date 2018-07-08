class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
  
  validates :article_id, presence: true, numericality: true
  validates :category_id, presence: true, numericality: true
end