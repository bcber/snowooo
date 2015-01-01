module Mongoid
  module Topable
    extend ActiveSupport::Concern

    included do
      field :top_at, type: Time, default:nil

      scope :top, ->{ where(:top_at.ne => nil).desc(:top_at) }
    end

    def top?
      self.top_at.present?
    end

    def pushToTop
      self.update(top_at: Time.now)
    end

    def cancelTop
      self.update(top_at: nil)
    end
  end
end
