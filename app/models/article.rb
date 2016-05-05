class Article < ActiveRecord::Base
    belongs_to :page

    has_attached_file :photo, styles: { medium: '500x500>', thumb: '250x250>' }
    validates_attachment_content_type :photo, content_type: /\Aimage\/(png|gif|jpeg)/,
                                              message: 'niepoprawne rozszerzenie pliku (dopuszczalne png, gif, jpg)'

    validates_attachment_size :photo,
                              in: 0..850.kilobytes,
                              message: 'błąd, plik jest za duży (maksymalny rozmiar: 850KB)'

    validates :name,
              presence: true,
              length: { maximum: 60, message: '- za długi tytuł! ' }

    scope :visible, -> { where(visible: true) }
    scope :invisible, -> { where(visible: false) }
    scope :sort, -> { order('articles.position ASC') }
    scope :newest, -> { order('articles.created_at DESC').limit(3) }
end
