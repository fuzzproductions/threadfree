class SearchController < ApplicationController
  
  def index
    
    @relevant_designs = Design.search(params[:query])
  
  end

end
