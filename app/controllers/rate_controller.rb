class RateController < ApplicationController
  
  def index
    @display_design = Design.find_by_id(pick_design) 
  end


  private
  
    def pick_design
      @number_designs = Design.last.id
      while @picked_design == nil
        @picked_design = Design.find_by_id(1 + rand(@number_designs))
      end
      return @picked_design.id
    end
    
end
