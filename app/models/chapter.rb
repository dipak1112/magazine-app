class Chapter < ActiveRecord::Base
  attr_accessible :chapter_no, :name, :chapter_start, :chapter_end

  belongs_to :book
  has_many :pages, :dependent => :destroy
  accepts_nested_attributes_for :pages, allow_destroy: true

end
