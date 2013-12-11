class Book < ActiveRecord::Base
  attr_accessible :author, :name, :title,:publish_date, :cover_photo
  

  has_many :pages, :dependent => :destroy
  has_many :chapters, :dependent => :destroy

  validates :name, :title, :author, :presence => true

  accepts_nested_attributes_for :chapters, allow_destroy: true
  
  has_attached_file :cover_photo,
    :path => "#{Rails.root.to_s}/public/cover_photo/:attachment/:id/:style/:filename",
    :url => "/cover_photo/:attachment/:id/:style/:filename"

  def display_errors
    self.errors.full_messages.join(', ')
  end
 
  def is_even?
    self.pages.count%2 == 1
  end

  def cover_image_url
    if self.cover_photo.present?
      self.cover_photo.path
    end
  end

end
