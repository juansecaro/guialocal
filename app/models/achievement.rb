class Achievement < ApplicationRecord
  belongs_to :user, optional: true
  validates_uniqueness_of :user_id
end
