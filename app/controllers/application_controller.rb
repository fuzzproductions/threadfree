# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout 'public'
  alias_method :rescue_action_locally, :rescue_action_in_public

  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :redirect_no_www, :init_user
  # before_filter :save_uri, :except => [:controller => :comments]
  
  private
    # def save_uri
    #   session[:original_uri] = request.request_uri
    # end
  
    def init_user
      @pages = Page.all
      @search = Design.search
      if session[:user_id].nil?
        if cookies[:remember_me_id].nil?
          return
        else
          session[:user_id] = cookies[:remember_me_id]
        end
      end
      @current_user = User.find_by_id(session[:user_id])
      if @current_user == nil
        session[:user_id] = nil
        return
      end
      @total_designs = 0
      @total_downloads = 0
      @total_ratings = 0
      @current_user_designs = Design.user_id_is(@current_user.id)
      @current_user_designs.each do |users_design|
        @total_designs += 1
        @total_downloads += users_design.times_downloaded
        @total_ratings += users_design.times_rated
      end
    end
  
    def authorize_admin
      authenticate_or_request_with_http_basic do |username, password|
        username == "Neal" && password == "threadfreeftw!"
      end
    end
    
    def render_optional_error_file(status_code)
      if status_code == :not_found
        redirect_to :controller => "home", :action => "error_404"
      else
        redirect_to :controller => "home", :action => "error_500"
      end
    end

    
    
    
    
  protected
    
    def redirect_no_www   
      if request.host.match(/^www/)
        headers["Status"] = "301 Moved Permanently"
        redirect_to(request.protocol + request.host.gsub(/^www./, '') + request.path)
      end
    end
    
    # def basic_auth
    #   authenticate_or_request_with_http_basic do |username, password|
    #     username == "Fuzz" && password == "3018fuzz"
    #   end
    # end
    
end
