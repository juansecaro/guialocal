class Incident < ApplicationRecord
  default_scope { order(created_at: :desc, updated_at: :desc) }
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: proc { |attributes| attributes['info'].blank? }

  enum status: [:abierto, :reportar, :pendiente, :concluida]
  after_initialize :set_default_status, :if => :new_record?


  def set_default_status
    self.status ||= :abierto
  end
end
