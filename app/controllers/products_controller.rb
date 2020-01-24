class ProductsController < ApplicationController
  before_action :authorize, only: [:show]
  before_action :authorize_admin, only: [:destroy, :create, :update, :new, :edit]

#within before_action, I could have every route execpt viewing a product and leaving a review blocked out. have a message display if they are trying to do things as a non user. perhaps create a static home page for those who haven't logged in.

  def index
    # Code for listing all albums goes here.
    @products = Product.all
    @mostreviewed = Product.mostreviewed
    render :index
  end

  def new
    # Code for new album form goes here.
    @product = Product.new
    render :new

  end

  def create
    # Code for creating a new album goes here
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product successfully added!"

      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    # Code for edit album form goes here.
    @product = Product.find(params[:id])
    render :edit
  end

  def show
    # Code for showing a single album goes here.
    @product = Product.find(params[:id])
    render :show
  end

  def update
    # Code for updating an album goes here.
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    # Code for deleting an album goes here.
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path

  end

  private
  def product_params
    params.require(:product).permit(:name, :cost, :country_of_origin )
  end

end
