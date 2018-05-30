class Punto < ApplicationRecord

  mount_uploaders :fotospunto, FotospuntoUploader
end
