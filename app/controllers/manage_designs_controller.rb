class ManageDesignsController < ApplicationController
  
  before_filter :check_user, :except => [:download_design, :gallery]
  
  def index
    redirect_to profile_url(:id => session[:user_id])
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
  
  def approve
    authorize_admin
    @pending_designs = Design.approved_is_not(true)
  end
  
  def approve_selected
    @selected_design = Design.find(params[:id])
    @selected_design.approved = true
    @selected_design.save
    redirect_to approval_page_url
  end
  
  def gallery
    @criteria = ["Newest", "Rating", "Downloads"]
    
    @approved_designs = Design.approved_is(true).all.sort_by { rand }
    @sorted_by = params[:sort_by]
    case params[:sort_by]
      when "Newest"
        @sorted_by_symbol = :created_at
      when "Rating"
        @sorted_by_symbol = :rating
      when "Downloads"
        @sorted_by_symbol = :times_downloaded
      else
    end
        
    if params[:sort_by] == nil or @sorted_by == "Random"
      @designs = @approved_designs.paginate(:page => params[:page], :per_page => 45)
    else
      @designs = @approved_designs.sort_by(&@sorted_by_symbol).reverse.paginate(:page => params[:page], :per_page => 45)
    end
  end
  
  protected
    
    def check_user
      if session[:user_id].nil?
        flash[:notice] = "Please login"
        redirect_to create_user_url
      end
    end

end
