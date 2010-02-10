class SearchController < ApplicationController
  
  def index
    
    @relevant_designs = Design.tags_like(params[:query][:tags_like]) + Design.name_like(params[:query][:tags_like])
  
  end

end
