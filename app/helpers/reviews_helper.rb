module ReviewsHelper
  
  def review_average(reviews)
    reviews.length > 0.0 ? reviews.inject(0.0) {|sum, r| sum + r.rank} / reviews.length : 0.0
  end
end
