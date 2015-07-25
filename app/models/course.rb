class Course < ActiveRecord::Base
    belongs_to :user
    validates :title, :presence => true
    validates :description, :presence => true
    validates :cost, :presence => true
    validate :cost_must_not_be_negative

    def cost_must_not_be_negative
      if cost == nil
        false
      elsif cost < 0
        false
      else
        true
      end
    end
end
