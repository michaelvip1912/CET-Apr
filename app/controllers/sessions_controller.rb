class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(encode: params[:session][:encode])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to :controller => 'home', :action => 'menu'
    else
      flash.now[:error] = '用户名或密码错误'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to  :controller => 'sessions', :action => 'new'
  end
end