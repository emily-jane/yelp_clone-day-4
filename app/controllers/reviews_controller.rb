class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build({thoughts: review_params[:thoughts],
                                        rating: review_params[:rating],
                                        user_id: current_user.id})
    if @review.save
      redirect_to restaurants_path
    else
      flash[:alert] = @review.errors.values.join("\n")
      redirect_to restaurants_path
    end
  end

  def destroy
    Review.find(params[:id]).destroy_as(current_user)
  
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
