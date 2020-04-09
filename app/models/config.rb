class Config < ApplicationRecord

  enum city: [:sinasignar, :llerena, :olivenza, :zafra, :delaserena]
  after_initialize :set_default_city, :if => :new_record?

  mount_uploader :header, HeaderUploader

  def set_default_city
    self.city ||= :sinasignar
  end

  def as_json options={}
  {
    city: city,
    number_of_points: number_of_points,
    number_of_promos: number_of_promos,
    number_of_events: number_of_events,
    header: header
  }
  end
end
