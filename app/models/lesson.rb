class Lesson < ActiveRecord::Base
  belongs_to :section

    validates :title, :presence => true
    validates :subtitle, :presence => true
end
