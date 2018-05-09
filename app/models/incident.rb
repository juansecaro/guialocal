class Incident < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: proc { |attributes| attributes['info'].blank? }

  enum status: [:abierto, :tramite, :pendiente, :cerrado]
  after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= :abierto
  end
end
