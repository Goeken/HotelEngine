class Search < ApplicationRecord
  validates :search_text, uniqueness: true
end
