class Api::V1::OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :destroy]
    before_action :authenticate_request
    before_action :admin_role, only: [:destroy]


    def index      
    end

    #GET /orders
    #Busca todas las ordenes existentes en la bd
    def orders
        @orders = Order.all 
        render json: @orders     
    end

    #GET /order/:id
    #Busca orden por id 
    def show
        render json: @order
    end

    #POST /new_order
    #Crea una nueva orden relacionando user_id y alimentando la tabla order_has_products
    #segun todo el objeto de productos que se generen en la orden. 
    #Calcula el valor total de las compras. 
    def create
        @order = Order.new(order_params)
        @order.total_order = calculate_order_total(order_params[:order_has_products_attributes])
        @order.date_order = Date.current
        @order.status_order = "Recibida"
        @order.user_id = @current_user.id

        if params[:order][:order_has_products_attributes].present?
            order_has_products_params = params[:order][:order_has_products_attributes].map do |product_params|
                product_id = product_params[:product_id].to_i
                cant = product_params[:cant].to_i
    
                product = Product.find_by(id: product_id)
                if product
                    # Validación de cantidad disponible
                    if cant > product.quantity
                        render json: { 
                            error: "No hay suficientes unidades disponibles para el producto '#{product.name}' (ID: #{product_id})" 
                        }, 
                        status: :unprocessable_entity and return
                    end
            
                    unit_price = product.price
                    total_price = unit_price * cant
                    product_params.merge(total_price: total_price, unit_price: unit_price)
                else
                    render json: { 
                            error: "Producto con ID #{product_id} no encontrado" 
                        }, 
                    status: :unprocessable_entity and return
                end
            end

            params[:order][:order_has_products_attributes] = order_has_products_params
        end

        if @order.save
            render json: { 
                    message: "Orden creada con éxito" 
                }, 
                status: :created
        else
            render json: { 
                    errors: @order.errors.full_messages 
                }, 
                status: :unprocessable_entity
        end
    end       

    #PUT /update_order/:id   
    #Se actualiza los campos de order segun el id
    def update
        if @order.update(order_params)
            render json: @order
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end

    # PUT /update_status/:num_order
    #Modifica el campo num_order de la tabla order segun el num_order
    #Puede tener distintos estados como 
    #"Enviado"
    #"Completado"
    def update_status
        @order = Order.find_by(num_order: params[:num_order])
    
        if @order.nil?
            render json: { 
                    error: "Orden no encontrada" 
                }, 
                status: :not_found
            return
        end
    
        new_status = params[:status_order]
    
        if new_status.blank?
            render json: { 
                    error: "El nuevo estado no puede estar en blanco" 
                }, 
                status: :unprocessable_entity
            return
        end
    
        @order.update(status_order: new_status)
        
        render json: { 
                message: "Estado de la orden actualizado exitosamente" 
            }, 
            status: :ok
    end

    #DELETE /delete_order/:id
    #Elimina una orden por id 
    def destroy
        if @order.destroy
            render json: { 
                    message: "orden eliminada exitosamente" 
                }, 
                status: :ok
        else
            render json: { 
                    error: "No se pudo eliminar el ordero" 
                }, 
                status: :unprocessable_entity
        end
    end


    private

    #Metodo para buscar ordenes por Id 
    def set_order
        @order = Order.find_by(id: params[:id])
        if @order.nil?
            render json: { 
                    error: "Orden no encontrada" 
                }, 
                status: :not_found
        end
    end

    #Calcula el total de la orden segun los productos enviados 
    def calculate_order_total(order_has_products_params)
        total = 0
        order_has_products_params.each do |item|
            product = Product.find(item[:product_id])
            total += product.price * item[:cant].to_i
        end
        total
    end
    
    #Parametros para almacenar en Order
    def order_params
        params.require(:order).permit(
            :num_order, :date_order, :total_order, :status_order, :user_id, 
            order_has_products_attributes: [:cant, :product_id]
        )
    end


end
