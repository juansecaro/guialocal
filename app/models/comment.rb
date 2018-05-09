class Comment < ApplicationRecord

  default_scope { order(created_at: :desc) }

  belongs_to :user, optional: true
  belongs_to :incident
end
