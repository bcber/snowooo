class ReviewsController < ApplicationController

  def create
    @reviewable = find_reviewable
    @review = @reviewable.reviews.build(review_params)
    @review.user = current_user

    @reviewable.rate(@review.stars,current_user)

    if @review.save
      redirect_to @reviewable, notice: "点评成功"
    else
      render :edit, alert: "点评失败"
    end
  end

  private
  def review_params
    params.require(:review).permit(:good,:bad,:composite,:stars)
  end

  def find_reviewable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end