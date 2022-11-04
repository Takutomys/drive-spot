class Public::TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_end_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      redirect_to new_tweet_path
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.page(params[:page]).per(7).reverse_order
  end

  def edit
    @tweet = Tweet.find(params[:id])
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
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    redirect_to tweet_path(@tweet)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
     params.require(:tweet).permit(:end_user_id, :name, :introduction, :latitude, :longitude, :address)
  end
end
