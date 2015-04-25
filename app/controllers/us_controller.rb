class UsController < ApplicationController

  def show
    @u = U.find(params[:id])
  end

  def new
    @u = U.new
  end

  private

    def u_params
      params.require(:u).permit(:name, :email, :password,
                                   :password_confirmation)
    end
   
  public
  def create
    @u = U.new(u_params)    # Not the final implementation!
    if @u.save
      log_in @u
      flash[:success] = "Welcome to Symporter"
      redirect_to @u
    else
      render 'new'
    end
    
    
    
  end
end
