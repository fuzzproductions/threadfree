class Comment < ActiveRecord::Base
  belongs_to :user
  
  validates_length_of :comment_text, :within => 2..2500, :too_short => " - Your comment should be a little more substantial than that", :too_long => " - You only get 2500 characters per comment. Be succinct. Be positive. Be profound."
  # validates_presence_of :user_id
  # validates_presence_of :design_id
  
end
