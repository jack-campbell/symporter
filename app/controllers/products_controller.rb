class ProductsController < ApplicationController
 before_action :logged_in_u, only: [:create, :destroy]

  def create
    @product = current_u.products.build(product_params)
    if @product.save
      flash[:success] = "Product Uploaded!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end 
  
  def destroy
  end
  
   def index
  @products = Product.all
  end

  
  private
 

  
  def product_params
    params.require(:product).permit(:content)
    end
end 