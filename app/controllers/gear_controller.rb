class GearController < ApplicationController
  def snowboard
    @snowboards = Snowboard.desc(:recommend_at).limit(8)
  end

  def snowboot
    @snowboots = Snowboot.desc(:recommend_at).limit(8)
  end

  def snowbinding
    @snowbindings = Snowbinding.desc(:recommend_at).limit(8)
  end
end