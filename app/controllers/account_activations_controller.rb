class AccountActivationsController < ApplicationController
   def edit
    u = U.find_by(email: params[:email])
    if u && !u.activated? && u.authenticated?(:activation, params[:id])
      u.activate
      log_in u
      flash[:success] = "Account activated!"
      redirect_to u
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end

