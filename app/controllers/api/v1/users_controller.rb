class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authenticate_request, except: [:create]

    #GET /users
    def users
        @users = User.all 
        render json: @users
    end   

    #GET /user/:id 
    def show
        render json: @user
    end

    #POST /new_user
    def create
        @user = User.new(user_params)
        if @user.save
            render json: { 
                    message: "Usuario creado con éxito" 
                }, 
                status: :created
        else
            render json: { 
                    errors: @user.errors.full_messages 
                }, 
                status: :unprocessable_entity
        end
    end

    #PUT /update_user/:id
    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    #DELETE /delete_user/:id
    def destroy
        if @user.destroy
            render json: { 
                    message: "Usuario eliminado exitosamente" 
                }, 
                status: :ok
        else
            render json: { 
                    error: "No se pudo eliminar el usuario" 
                }, 
                status: :unprocessable_entity
        end
    end
    
    private

    def set_user
        @user = User.find_by(id: params[:id])
        if @user.nil?
            render json: {
                error: "Usuario no existe",
                status: :not_found
            }  
        end
    end    

    def user_params
        params.require(:user).permit(:name, :email, :username, :password, :role, :phone, :address)
    end

end
