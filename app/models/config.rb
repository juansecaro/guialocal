class Config < ApplicationRecord

  enum city: [:sinasignar, :llerena, :olivenza, :zafra, :delaserena]
  after_initialize :set_default_city, :if => :new_record?


  def set_default_city
    self.city ||= :sinasignar
  end


end
