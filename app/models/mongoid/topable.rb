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

    def set_top
      self.update(top_at: Time.now)
      Top.create!(topable_id: self.id, topable_type: self.class.to_s) unless Top.where(topable_id: self.id).exists?
    end

    def cancel_top
      self.update(top_at: nil)
      Top.where(topable_id: self.id).delete
    end
  end
end
