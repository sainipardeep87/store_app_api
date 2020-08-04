class CartsController < ApiController
    
    def index
        render json: {message: 'success', response: @current_user.carts, status: 200}
    end

    def create
        item = @current_user.carts.new(cart_params)
        if item.save
            render json: {message: "success", response: [], status: 200}
        else
            render json: {message: "error", response: item.errors.full_messages, status: 422}
        end
    end

    private

    def cart_params
        params.require(:cart).permit(:product_id, :price)
    end
end
