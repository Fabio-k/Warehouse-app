class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    
    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto salvo com sucesso'
    else
      @suppliers = Supplier.all
      flash[:notice] = 'Erro ao cadastrar modelo de produto'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
  end
end