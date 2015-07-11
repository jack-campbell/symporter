class PasswordResetsController < ApplicationController
  before_action :get_u,   only: [:edit, :update]
  before_action :valid_u, only: [:edit, :update]
   before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @u = U.find_by(email: params[:password_reset][:email].downcase)
    if @u
      @u.create_reset_digest
      @u.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:u][:password].empty?
      flash.now[:danger] = "Password can't be empty"
      render 'edit'
    elsif @u.update_attributes(u_params)
      log_in @u
      flash[:success] = "Password has been reset."
      redirect_to @u
    else
      render 'edit'
    end
  end
  
  private
  
   def u_params
      params.require(:u).permit(:password, :password_confirmation)
    end

    def get_u
      @u = U.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_u
      unless (@u && @u.activated? &&
              @u.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end 
      def check_expiration
      if @u.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
    end 