class HomeController < ApplicationController
  
  def index
    
    @fifteen_designs = []
    @most_downloaded = Design.all.sort_by(&:times_downloaded).reverse
    @highest_rated = Design.all.sort_by(&:rating).reverse
    @approved_designs = Design.approved_is(true)
    
    @fifteen_designs << @most_downloaded.first
    @fifteen_designs << @highest_rated.first
    @fifteen_designs << @approved_designs.first(:offset => (0..(@approved_designs.count-1)).to_a.rand)
    
    @fifteen_designs << @most_downloaded.second
    @fifteen_designs << @highest_rated.second
    @fifteen_designs << @approved_designs.first(:offset => (0..(@approved_designs.count-1)).to_a.rand)
    
    @fifteen_designs << @most_downloaded.third
    @fifteen_designs << @highest_rated.third
    @fifteen_designs << @approved_designs.first(:offset => (0..(@approved_designs.count-1)).to_a.rand)
    
    @fifteen_designs << @most_downloaded.fourth
    @fifteen_designs << @highest_rated.fourth
    @fifteen_designs << @approved_designs.first(:offset => (0..(@approved_designs.count-1)).to_a.rand)
    
    @fifteen_designs << @most_downloaded.fifth
    @fifteen_designs << @highest_rated.fifth
    @fifteen_designs << @approved_designs.first(:offset => (0..(@approved_designs.count-1)).to_a.rand)
    
  end
  
  def error_404
  end
  
  def error_500
  end


end
