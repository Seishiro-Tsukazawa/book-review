class Book < ApplicationRecord
  #別ファイルでユニーク制約
  validates :title, :author, :publisher, :isbn, presence: true
  has_many :reviews
end
