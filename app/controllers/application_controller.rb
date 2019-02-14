class ApplicationController < ActionController::Base

  def check_signin
    if session[:username].blank?
      redirect_to controller: 'users', action:'auth'
    end
  end

  def check_auth
    if !session[:username].blank?
      redirect_to controller: 'products'
    end
  end
end
