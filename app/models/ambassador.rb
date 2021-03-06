class Ambassador < ApplicationRecord


  extend FriendlyId
  friendly_id :name, use: :slugged

  enum country: [:spain, :portugal, :england, :bulgaria, :czechia, :ukraine, :france, :germany, :egypt, :russia, :greece, :hungary, :italy,
     :lithuania, :macedonia, :malta, :poland, :romania, :serbia, :slovenia]
  enum language: [:spanish, :portuguese, :english, :bulgarian, :czech, :ukrainian, :french, :german, :arabic, :russian, :greek, :hungarian,
     :italian, :lithuanian, :macedonian, :polish, :romanian, :serbian, :slovene]
  enum gender: [:male, :female]

  mount_uploader :picture, ImgambassadorUploader
  mount_uploaders :gallery, AmbassadorGalleryUploader

end
