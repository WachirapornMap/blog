class UsersController < ApplicationController
  def auth
    check_auth
  end
  def signout
    reset_session
    render html: "<script>window.location='#{params[:url]}'</script>".html_safe #clear timestam ของหน้าเพจ เพื่อไม่ให้กด back ได้
    #render 'auth'
  end
  def signin
    @user = User.where("  username = ? AND password = ?", "#{params[:form][:username]}", "#{params[:form][:password]}").first
    if !@user.blank?
      session[:username] = @user.username
      session[:userid] = @user.id
      render html: "<script>window.location='#{auth_path}'</script>".html_safe
      #redirect_to controller: 'products'
    else
      redirect_to auth_path, notice: 'Username or Password incorrect'
    end
  end
end
