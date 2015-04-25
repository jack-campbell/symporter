module SessionsHelper
  def log_in(u)
    session[:u_id] = u.id
  end
  def remember(u)
    u.remember
    cookies.permanent.signed[:u_id] = u.id
    cookies.permanent[:remember_token] = u.remember_token
  end
  def current_u
    if (u_id = session[:u_id])
      @current_u ||= U.find_by(id: u_id)
    elsif (u_id = cookies.signed[:u_id])
      u = U.find_by(id: u_id)
      if u && u.authenticated?(cookies[:remember_token])
        log_in u
        @current_u = u
      end
    end
  end
def logged_in?
    !current_u.nil?
  end
  def log_out
    session.delete(:u_id)
    @current_u = nil
  end
end
