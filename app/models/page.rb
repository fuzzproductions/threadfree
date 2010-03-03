class Page < ActiveRecord::Base
  
  def to_param
    page_url
  end
  
end
