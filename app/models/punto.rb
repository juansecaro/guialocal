class Punto < ApplicationRecord
  before_destroy :clean_s3

  mount_uploaders :fotospunto, FotospuntoUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  private
  def clean_s3
    fotospunto.each(&:remove!)
  rescue Excon::Errors::Error => error
    puts "Couldn't be removed"
    false
  end

end
