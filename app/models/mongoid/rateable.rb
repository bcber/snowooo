module Mongoid
  module Rateable

    extend ActiveSupport::Concern

    included do
      field :rate_5, type: Integer,default:0
      field :rate_4, type: Integer,default:0
      field :rate_3, type: Integer,default:0
      field :rate_2, type: Integer,default:0
      field :rate_1, type: Integer,default:0
      field :rate_average, type: Float, default: 0
    end

    def update_rate
      update(rate_1: rates.where(stars: 1).count)
      update(rate_2: rates.where(stars: 2).count)
      update(rate_3: rates.where(stars: 3).count)
      update(rate_4: rates.where(stars: 4).count)
      update(rate_5: rates.where(stars: 5).count)
      update(rate_average: rates.pluck(:stars).inject(0){|sum,star| sum + star}/rates.count.round(1))
    end

    def rate(stars, user)
      if can_rate? user
        rates.create! do |r|
          r.stars = stars
          r.rater = user
        end
        update_rate
      end
    end

    def update_rate_average_dirichlet(stars, dimension=nil)
      ## assumes 5 possible vote categories
      dp = {1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1}
      stars_group = Hash[rates(dimension).group(:stars).count.map{|k,v| [k.to_i,v] }]
      posterior = dp.merge(stars_group){|key, a, b| a + b}
      sum = posterior.map{ |i, v| v }.inject { |a, b| a + b }
      davg = posterior.map{ |i, v| i * v }.inject { |a, b| a + b }.to_f / sum

      if average(dimension).nil?
        send("create_#{average_assoc_name(dimension)}!", { avg: davg, qty: 1, dimension: dimension })
      else
        a = average(dimension)
        a.qty = rates(dimension).count
        a.avg = davg
        a.save!(validate: false)
      end
    end

    def update_rate_average(stars, dimension=nil)
      if average(dimension).nil?
        send("create_#{average_assoc_name(dimension)}!", { avg: stars, qty: 1, dimension: dimension })
      else
        a = average(dimension)
        a.qty = rates(dimension).count
        a.avg = rates(dimension).average(:stars)
        a.save!(validate: false)
      end
    end

    def update_current_rate(stars, user, dimension)
      current_rate = rates.where(rater_id: user.id, dimension: dimension).take
      current_rate.stars = stars
      current_rate.save!(validate: false)

      if rates(dimension).count > 1
        update_rate_average(stars, dimension)
      else # Set the avarage to the exact number of stars
        a = average(dimension)
        a.avg = stars
        a.save!(validate: false)
      end
    end

    def overall_avg(user)
      # avg = OverallAverage.where(rateable_id: self.id)
      # #FIXME: Fix the bug when the movie has no ratings
      # unless avg.empty?
      #   return avg.take.avg unless avg.take.avg == 0
      # else # calculate average, and save it
      #   dimensions_count = overall_score = 0
      #   user.ratings_given.select('DISTINCT dimension').each do |d|
      #     dimensions_count = dimensions_count + 1
      #     unless average(d.dimension).nil?
      #       overall_score = overall_score + average(d.dimension).avg
      #     end
      #   end
      #   overall_avg = (overall_score / dimensions_count).to_f.round(1)
      #   AverageCache.create! do |a|
      #     a.rater_id = user.id
      #     a.rateable_id = self.id
      #     a.avg = overall_avg
      #   end
      #   overall_avg
      # end
    end

    def can_rate?(user)
      not rated?(user)
    end

    def rated?(user)
      rates.where(rater_id: user.id).any?
    end

    module ClassMethods

      def ratyrate_rater
        has_many :ratings_given, :class_name => "Rate", :foreign_key => :rater_id
      end

      def ratyrate_rateable
        has_many :rates, :as => :rateable, :class_name => "Rate", :dependent => :destroy
        has_many :raters, :class_name => 'User'
      end
    end
  end
end