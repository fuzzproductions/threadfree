class SearchController < ApplicationController
  
  def index
    
    if params[:query]
      @display_query = params[:query]
      @terms = params[:query].to_s.split(" ")
      @relevant_designs = Design.search(:tags_or_name_like_any => @terms).sort_by(&:rating).reverse.paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to gallery_url
    end
  
  
  end

end
