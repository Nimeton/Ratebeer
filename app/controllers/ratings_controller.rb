class RatingsController < ApplicationController

  before_filter :ensure_that_signed_in, :except => [:index]

  def index

    @ratings = Rating.all
    @topbeers = Beer.top(3)
    @topbreweries = Brewery.top(3)
    @topstyles = Style.top(3)
    @topusers = User.top(3)
    @recentratings = Rating.recent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params[:rating]

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end
 
  def destroy
    rating = Rating.find params[:id]
    #rating.delete
    #redirect_to ratings_path
    rating.delete if currently_signed_in? rating.user
    redirect_to :back
  end

end
