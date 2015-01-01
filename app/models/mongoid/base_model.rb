module Mongoid
  module BaseModel
    extend ActiveSupport::Concern

    included do
      scope :recent, ->{ desc(:created_at) }
    end
  end
end