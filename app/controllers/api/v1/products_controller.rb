class Api::V1::ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authenticate_request
    before_action :admin_role, only: [:create, :update, :destroy]

    def index      
    end

    #GET /products
    #Muestra todos los productos de la tabla product
    def products
        @products = Product.all 
        render json: @products     
    end

    #GET /product/:id
    #Busca un producto por id
    def show
        render json: @product
    end

    #POST /new_product
    #Crea un nuevo producto
    def create
        @product = Product.new(product_params)
        if @product.save
            render json: { 
                    message: "Producto creado con éxito"
                }, 
                status: :created
        else
            render json: { 
                errors: @product.errors.full_messages }, 
                status: :unprocessable_entity
        end
    end       

    #PUT /update_product/:id
    #Modifica un producto por id
    def update
        if @product.update(product_params)
            render json: @product
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    #DELETE /delete_product/:id
    #Elimina un  producto por id
    def destroy
        if @product.destroy
            render json: { 
                message: "Producto eliminado exitosamente" 
                }, 
                status: :ok
        else
            render json: { 
                error: "No se pudo eliminar el producto" 
                }, 
                status: :unprocessable_entity
        end
    end


    private

    #Metodo para buscar ordenes por Id 
    def set_product
        @product = Product.find_by(id: params[:id])
        if @product.nil?
            render json: { 
                    error: "Producto no encontrado" 
                }, 
                status: :not_found
        end
    end
    
        #Parametros para almacenar en Product
    def product_params
        params.require(:product).permit(:name, :price, :quantity)
    end

end
