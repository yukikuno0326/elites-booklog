module ReviewsHelper
  
  def review_average(reviews)
    (reviews.length > 0.00 ? reviews.inject(0.00) {|sum, r| sum + r.rank} / reviews.length : 0.00).round(2)
  end
end
