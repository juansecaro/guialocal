class Evento < ApplicationRecord
  before_destroy :clean_s3

  mount_uploader :imgevento, ImgeventoUploader

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  def clean_s3
    imgevento.remove!
    imgevento.thumb.remove! # if you have thumb version or any other version
  rescue Excon::Errors::Error => error
    puts "Something gone wrong"
    false
  end
end
