class UsController < ApplicationController
  before_action :logged_in_u, only: [:index, :edit, :update, :destroy]
  before_action :correct_u,   only: [:edit, :update]
  before_action :admin_u,     only: :destroy
  
  def destroy
    U.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to us_url
  end
  
  def edit
    @u = U.find(params[:id])
  end

  def update
    @u = U.find(params[:id])
    if @u.update_attributes(u_params)
      flash[:success] = "Profile updated"
      redirect_to @u
    else
      render 'edit'
    end
  end
  
  def index
    @us = U.all
    if params[:search]
    @us = U.search(params[:search]).order("created_at DESC")
    else
    @us = U.all.order('created_at DESC')
    end
  end
  
  def show
    @u = U.find(params[:id])
    @products = @u.products.paginate(page: params[:page])
  end

  def new
    @u = U.new
  end

  private

    def u_params
      params.require(:u).permit(:name, :email, :password, :password_confirmation, :city, :institution)
    end
  
    def logged_in_u
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  
    def correct_u
      @u = U.find(params[:id])
      redirect_to(root_url) unless current_u?(@u)
    end
  
    def admin_u
      redirect_to(root_url) unless current_u.admin?
    end
  
  public
  
    def create
      @u = U.new(u_params)    # Not the final implementation!
      if @u.save
        @u.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
      render 'new'
    end   
  end
end
