class Incident < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments

  enum status: [:abierto, :tramite, :pendiente, :cerrado]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_status
    self.role ||= :abierto
  end
end
