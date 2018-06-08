class Category < ApplicationRecord
  validates :name, presence: true, length:{ minimum: 3 }, uniqueness: true
  has_many :empresas, dependent: :nullify

end
