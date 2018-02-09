class Empresa < ApplicationRecord
  before_create :set_schedule

  attr_accessor :tag_list

  belongs_to :user
  belongs_to :category
  has_many :offers, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  mount_uploader :logo, LogoUploader
  mount_uploaders :fotos, FotosUploader

  def tag_list
    tags.join(", ")
  end

  def tag_list=(names)
    tag_names = names.split(",").collect {|str| str.strip.downcase}.uniq
    new_or_existing_tags = tag_names.collect {|tag_name| Tag.find_or_create_by(name: tag_name)}

    self.tags = new_or_existing_tags
  end

  def set_schedule
    self.schedule = Array.new(28)
    for i in 0..27
      self.schedule[i] = nil
    end
  end

end
