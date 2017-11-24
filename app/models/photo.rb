class Photo < ApplicationRecord
  belongs_to :empresa
  belongs_to :offer
end
