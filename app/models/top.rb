class Top
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :topable_id
  field :topable_type

  field :position, type: Integer, default: nil

  default_scope  ->{ desc(:position) }

  def model
    self.topable_type.classify.constantize.unscoped.find(self.topable_id)
  end

  def self.update_position(new_position,old_position)
    m = Top.find_by(position: old_position)

    minP = [old_position,new_position].min
    maxP = [old_position,new_position].max

    Top.where(:position.gte => minP, :position.lt => maxP).map do |p|
      p.update_attributes!(position: p.position+1)
    end

    m.update_attributes!(position: new_position)
  end

  before_validation :set_position
  private
  def set_position
    if self.position.nil?
      maxPosition = Top.max(:position)
      self.position = maxPosition.present? ? maxPosition+1 : 0
    end
  end
end