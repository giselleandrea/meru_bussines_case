class ApplicationController < ActionController::API
    include JsonWebToken

    protected

    #Respuesta de la generacion del token dispuesto desde app/controllers/concerns/json_web_token.rb
    def authenticate_request
        puts "Auth token: #{auth_token}"
        render_failed and return unless token?
	    @current_user = User.find_by(id: auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
        render_failed
    end

    #validacion del rol de usuario logueado. 
    #se manejan dos tipo
    #'admin2 y 'customer'
    def admin_role
        unless @current_user && @current_user.role == 'admin'
            render json: { 
                errors: ['Permiso denegado.'] }, 
                status: :forbidden
            return
        end
    end

    private   

    #Validaciones usando la gema de jwt y bcrypt para crear el token     
    def render_failed (messages = ['Token no válido'])
    	render json: { 
            errors: messages
        }, 
        status: :unauthorized
	end

    def http_token
    	@http_token ||= request.headers['Authorization']&.split(' ')&.last
    end

    def auth_token
        decoded = jwt_decode(http_token)
	    @auth_token ||= decoded
    end

    def token?
    	http_token && auth_token && auth_token[:user_id].to_i
    end 

end
