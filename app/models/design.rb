class Design < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  belongs_to :user
  
  validate :validate_dimensions
  
  validates_presence_of :name
  validates_length_of :name, :within => 2..50, :too_short => " - That title's too short.", :too_long => " - That title's too long."
  validates_length_of :description, :maximum => 260, :too_long => " - Your description is too long, if you could pare it down a bit..."
  validates_presence_of :tags
  
  attr_accessor :legal
  validates_presence_of :legal, :on => :create
  
  has_attached_file :design_picture, :styles => { :preview => "175x200#", :display => "490x560#"}
  
  validates_attachment_presence :design_picture
  validates_attachment_size :design_picture, :in => 500.kilobytes..10.megabytes, :message => " - You need to upload a picture between 500 kilobytes and 10 megabytes. If you submit one smaller, it won't be high enough quality for people to print when they download it."
  validates_attachment_content_type :design_picture, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']
  
  def validate_dimensions
    errors.add :design_picture, "needs to be at least 1000 pixels wide and 1000 pixels high. If it's smaller than that, the design really won't look very good when someone tries to print it." if design_picture.width < 1000 or design_picture.height < 1000
  end
  
end
