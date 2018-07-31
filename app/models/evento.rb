class Evento < ApplicationRecord
  before_destroy :clean_s3, prepend: true

  mount_uploader :imgevento, ImgeventoUploader

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  private
  def clean_s3
    self.remove_imgevento!
  rescue Excon::Errors::Error => error
    puts "Something gone wrong"
    false
  end
end
