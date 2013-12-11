class Page < ActiveRecord::Base
  attr_accessible :content,:page_number
  belongs_to :chapter
  belongs_to :book
  after_create :add_page_number,:book_page_number_manage

  validates :content, length: { maximum: 1800 }

  def add_page_number
    if self.book.pages.count == 0
      self.page_number = 0
    else
      self.page_number = self.book.pages.count
    end
    self.save
  end

  def book_page_number_manage
    self.chapter.update_attributes(:chapter_start => self.chapter.pages.first.page_number)
    self.chapter.update_attributes(:chapter_end => self.chapter.pages.last.page_number)
  end
end
