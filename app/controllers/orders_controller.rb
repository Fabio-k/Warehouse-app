class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_paranms = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_paranms)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Erro ao cadastrar pedido'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params[:query]
    @orders = Order.where "code LIKE ?", "%#{@code}%"
  end
end