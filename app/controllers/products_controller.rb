class ProductsController < ApplicationController
 before_action :logged_in_u, only: [:create, :destroy]

  def create
    @product = current_u.products.build(product_params)
    if @product.save
      flash[:success] = "Product Uploaded!"
      redirect_to root_url
    else
      render 'static_pages/products'
      @feed_items = []
      flash[:danger] = "Error uploading product."
    end
  end 
  
  def new
    @product = Product.new
  end
  
  def destroy
  end
  
   def index
  @products = Product.all
  if params[:search]
    @products = Product.search(params[:search]).order("created_at DESC")
  else
    @products = Product.all.order('created_at DESC')
end
  end

  
  private
 

  
  def product_params
    params.require(:product).permit(:description,:name)
    end
end 