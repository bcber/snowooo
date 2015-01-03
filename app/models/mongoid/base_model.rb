module Mongoid
  module BaseModel
    extend ActiveSupport::Concern

    included do
      scope :recent, ->{ desc(:created_at) }
      field :views_count, type: Integer, default: 0
    end

    def view
      self.inc(views_count: 1)
    end
  end
end