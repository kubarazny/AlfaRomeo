class Photo < ActiveRecord::Base
    belongs_to :gallery

    has_attached_file :photo, styles: { medium: '500x500>', thumb: '250x250>' }
    validates_attachment_content_type :photo, content_type: /\Aimage\/(png|gif|jpeg)/,
                                              message: 'niepoprawne rozszerzenie pliku (dopuszczalne: png, gif, jpg)'

    validates_attachment_size :photo,
                              in: 0..850.kilobytes,
                              message: 'błąd, plik jest za duży (maksymalny rozmiar: 850KB)'

    validates :name,
              presence: true,
              length: { maximum: 60, message: '- too long title! ' }

    scope :visible, -> { where(visible: true) }
    scope :invisible, -> { where(visible: false) }
    scope :sort, -> { order('photos.position ASC') }
    scope :newest, -> { order('photos.created_at DESC') }
end
