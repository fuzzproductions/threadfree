class ManageDesignsController < ApplicationController
  
  before_filter :check_user, :except => :download_design
  
  def index
    @user_designs = Design.user_id_is(session[:user_id])
  end

  def upload
    @design = Design.new(params[:design])
    @design.user_id = session[:user_id]
    @design.times_rated = 1
    @design.rating = 250
    @design.times_downloaded = 0
    @design.approved = false
    if request.post? and @design.save
      flash.now[:notice] = "Your design #{@design.name} was uploaded! It should be approved and available soon."
    end
  end
  
  def download_design
    @design = Design.find(params[:design_id])
    puts '!!!DOWNLOAD_DESIGN CALLED!!!'
    @design.times_downloaded += 1
    @design.save
    redirect_to @design.design_picture.url
  end
  
  protected
    
    def check_user
      if session[:user_id].nil?
        flash[:notice] = "Please login"
        redirect_to create_user_url
      end
    end

end
