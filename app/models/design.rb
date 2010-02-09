class Design < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :name
  validates_length_of :name, :within => 2..50, :too_short => "Sorry, that title's too short.", :too_long => "Sorry, that title's too long."
  validates_length_of :description, :maximum => 260, :too_long => "Unfortunately, your description is too long, if you could pare it down a bit..."
  validates_presence_of :tags
  
  has_attached_file :design_picture, :styles => { :preview => "250x300", :display => "560x620"}
  
  validates_attachment_presence :design_picture
  validates_attachment_size :design_picture, :in => 500.kilobytes..10.megabytes, :message => "You need to upload a picture between 500 kilobytes and 10 megabytes. If you submit one smaller, it won't be high enough quality for people to print when they download it."
  validates_attachment_content_type :design_picture, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']
  
  
  
end
