class Public::TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_end_user.tweets.new(tweet_params)
    @tweet.save
    redirect_to tweets_path
  end

  def show
  end

  def edit
  end

  def index
    if params[:search].present?
      @tweets = Tweet.where('address LIKE ?', "%#{params[:search]}%")

      if @tweets.empty?
        @tweets = Tweet.order(created_at: :desc).limit(4)
      end
    else
      @tweets = Tweet.order(created_at: :desc).limit(4)
    end

    gon.tweets = Tweet.eager_load(:end_user)
    gon.first_latitude = @tweets.first.latitude
    gon.first_longitude = @tweets.first.longitude

  end

  def update
  end

  def destroy
  end

  private

  def tweet_params
     params.require(:tweet).permit(:end_user_id, :name, :introduction, :latitude, :longitude, :address)
  end
end
