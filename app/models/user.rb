class User < ApplicationRecord
    has_many :orders
    require 'securerandom'
    has_secure_password

    validates :username, presence: { message: "El nombre de usuario es obligatorio" }
    validates :email, presence: { message: "El email es obligatorio" }
    validates :password, presence: { message: "la contraseña es obligatorio" }, length: {minimum:6}
    validates :role, inclusion: { in: %w(admin customer), message: "El rol debe ser 'admin' o 'user'" }
    

end
