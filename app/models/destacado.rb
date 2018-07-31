class Destacado < ApplicationRecord
  before_destroy :clean_s3
  mount_uploader :imgdestacado, ImgdestacadoUploader

  private
  def clean_s3
    self.remove_imgdestacado!
  rescue Excon::Errors::Error => error
    puts "Something gone wrong"
    false
  end
end
