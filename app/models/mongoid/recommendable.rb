module Mongoid
  module Recommendable
    extend ActiveSupport::Concern

    included do
      field :recommend_at, type: Time, default:nil
      scope :recommend, ->{ where(:recommend_at.ne => nil).desc(:recommend_at) }
    end

    def recommend?
      self.recommend_at.present?
    end

    def set_recommend
      update(recommend_at: Time.now)
    end

    def cancel_recommend
      update(recommend_at: nil)
    end
  end
end
