class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :content, presence: true
  has_rich_text :content
  broadcasts_to :question
  
end
