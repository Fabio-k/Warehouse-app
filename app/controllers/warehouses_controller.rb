class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)  
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      redirect_to root_path
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :area, :address, :description, :cep, :city)
  end
end