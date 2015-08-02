class Lesson < ActiveRecord::Base
  belongs_to :section
  mount_uploader :video, VideoUploader
  
    validates :title, :presence => true
    validates :subtitle, :presence => true
end
