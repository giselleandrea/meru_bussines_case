#Codificacion y decodificacin del token 
require "jwt"

module JsonWebToken
    extend ActiveSupport::Concern
    
    SECRET_KEY = Rails.application.credentials.secret_key_base

    def jwt_encode(payload)
        JWT.encode(payload, SECRET_KEY)
    end

    def jwt_decode(token)
        begin
            decoded = JWT.decode(token, SECRET_KEY)[0]
            HashWithIndifferentAccess.new(decoded)
        rescue JWT::DecodeError => e
            render json: { 
                error: "Error en la decodificación del token: #{e.message}" }, 
                status: :unauthorized
        end
    end
end