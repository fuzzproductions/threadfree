require 'digest/sha1'

class User < ActiveRecord::Base
  
  has_many :designs, :dependent => :destroy
  has_many :comments
  
  validates_presence_of     :name
  validates_uniqueness_of   :name
  validates_format_of       :name, :with => /\A\w+\z/
  
  validates_uniqueness_of   :email_address, :message => "That email address has already been used to set up an account."
  validates_format_of       :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validates_length_of       :password, :if => :password, :minimum => 6, :too_short => "Your password has to be a least 6 characters."
  
  has_attached_file :profile_picture
  
  validates_attachment_presence :profile_picture, :on => :create
  validates_attachment_size :profile_picture, :on => :create, :less_than => 300.kilobytes
  validates_attachment_content_type :profile_picture, :on => :create, :content_type => ['image/jpeg', 'image/png']
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password, :if => :password
  
  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "quirk" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.id.to_s + rand.to_s
  end
  
end