class SessionsController < ApplicationController
  def new
  end

  def create
    u = U.find_by(email: params[:session][:email].downcase)
    if u && u.authenticate(params[:session][:password])
      log_in u
      params[:session][:remember_me] == '1' ? remember(u) : forget(u)
      redirect_back_or u
    else
      flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
