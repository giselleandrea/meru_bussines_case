class Api::V1::AuthenticationController < ApplicationController
    before_action :authenticate_request, except: [:login]

    #POST /auth/login
    #Validacion para login de usuario y respuesta de token, en este caso muestra tambien el rol
    def login
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: { 
                    token: token,
                    role: @user.role 
                }, 
                status: :ok
        else
            render json: {
                    error: "Datos incorrectos" 
                }, 
                status: :unauthorized    
        end      
    end
end
