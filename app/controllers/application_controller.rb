# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout 'public'
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :redirect_no_www, :init_user
  # before_filter :save_uri, :except => [:controller => :comments]
  
  private
    # def save_uri
    #   session[:original_uri] = request.request_uri
    # end
  
    def init_user
      if session[:user_id].nil?
        if cookies[:remember_me_id].nil?
          return
        else
          session[:user_id] = cookies[:remember_me_id]
        end
      end
      @search = Design.search
      @current_user = User.find_by_id(session[:user_id])
      @pages = Page.all
      @total_designs = 0
      @total_downloads = 0
      @total_ratings = 0
      @current_user_designs = Design.user_id_like(@current_user.id)
      @current_user_designs.each do |users_design|
        @total_designs += 1
        @total_downloads += users_design.times_downloaded
        @total_ratings += users_design.times_rated
      end
    end
  
  protected
    
    def redirect_no_www      
      if request.host.match(/^www/)
        headers["Status"] = "301 Moved Permanently"
        redirect_to(request.protocol + request.host.gsub(/^www./, '') + request.path)
      end
    end
    
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == "Fuzz" && password == "3018fuzz"
      end
    end
    
end
