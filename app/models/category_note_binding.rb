class CategoryNoteBinding < ActiveRecord::Base
  belongs_to :category
  belongs_to :note

  before_create :update_position
  
  
  
  def update_position
    self.position = CategoryNoteBinding.maximum('position')
    if(self.position == nil)
      self.position = 1
    else
      self.position += 1
    end  
  end
end
