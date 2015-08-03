class StaticPagesController < ApplicationController
  def home
     @products = Product.all
  if params[:search]
    @products = Product.search(params[:search]).order("created_at DESC")
  else
    @products = Product.all.order('created_at DESC')

end
  end

  def about
  end

  def market
  end

  def forum
  end

  def contact
  end

  def signup
  end
end