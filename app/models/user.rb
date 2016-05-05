class User < ActiveRecord::Base
    has_secure_password

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

    validates :name,
              presence: true

    validates :surname,
              presence: true

    validates :user,
              length: { within: 4..25, message: "nazwa użytkownika musi się składać co najmniej z 4 i co najwyżej z 25 znaków" },
              uniqueness: true

    validates :email,
              presence: true,
              length: { maximum: 100 },
              format: EMAIL_REGEX,
              confirmation: true

    scope :sort, -> { order('surname ASC, name ASC') }
    end
