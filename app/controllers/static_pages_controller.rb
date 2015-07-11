class StaticPagesController < ApplicationController
  def home
 
    if logged_in?
      @product  = current_u.products.build
      @feed_items = current_u.feed.paginate(page: params[:page])
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