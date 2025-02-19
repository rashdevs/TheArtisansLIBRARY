class User < ApplicationRecord
  has_many :books, foreign_key: "book_id"
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { maximum: 8 }
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { maximum: 10 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

