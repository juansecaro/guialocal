class Empresa < ApplicationRecord

  searchkick
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  skip_callback :validate, after: :create
  after_initialize :set_default_plan, :if => :new_record?

  attr_accessor :tag_list

  enum plan: [:noplan, :basic, :plus, :premium]

  belongs_to :user
  belongs_to :category, optional: true

  has_many :promos, dependent: :destroy

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

  def set_default_plan
    self.plan ||= :noplan
  end

end
