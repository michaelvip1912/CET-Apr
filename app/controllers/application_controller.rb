class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
   def authorize
    unless signed_in?
       flash[:notice] = '请登录后再使用系统'
       redirect_to root_url
     end
   end

 def admin_authorize
    unless signed_in? && (current_user.permission == "school_admin" ||
                           current_user.permission == "academy_admin")
         redirect_to root_url
    end
 end

end

