class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = current_user.restaurants.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if !current_user.nil? && current_user.id == @restaurant.user_id
      @restaurant.update(restaurant_params)
      redirect_to restaurants_path
    else
      flash[:alert] = 'You can only edit a restaurant you created'
      redirect_to restaurants_path
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if !current_user.nil? && current_user.id == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to restaurants_path
    else
      flash[:alert] = 'You can only delete a restaurant you created'
      redirect_to restaurants_path
    end
  end
end
