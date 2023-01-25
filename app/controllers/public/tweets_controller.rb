class Public::TweetsController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]
  def new
    @tweet = Tweet.new(spot_name: nil, introduction: nil)
  end

  def create
    @tweet = current_end_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.page(params[:page]).per(7).reverse_order
    @lat = @tweet.latitude
    @lng = @tweet.longitude
    gon.latitude = @lat
    gon.longitude = @lng
    gon.tweet_name = @tweet.spot_name
  end

  def edit
    @tweet = Tweet.find(params[:id])
    gon.tweet_latitude = @tweet.latitude
    gon.tweet_longitude = @tweet.longitude
  end

  def index
    if params[:search].present?
      @spot_tweets = Tweet.includes(:end_user).where(end_users: {status: "released"}).where('spot_name LIKE ?', "%#{params[:search]}%")
      @name_tweets = Tweet.includes(:end_user).where(end_users: {status: "released",screen_name:params[:search]})
      @tweets = @spot_tweets << @name_tweets
      if @tweets.empty?
        #@tweets = Tweet.includes(:end_user).where(end_users: {status: "released"}).order(created_at: :desc).limit(4)
      end
    else
      @tweets = Tweet.includes(:end_user).where(end_users: {status: "released"}).order(created_at: :desc).limit(4)
    end
    gon.tweets = @tweets
    if @tweets.present?
      gon.first_latitude = @tweets.first.latitude
      gon.first_longitude = @tweets.first.longitude
    end
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    redirect_to tweets_path
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
     params.require(:tweet).permit(:end_user_id, :spot_name, :introduction, :latitude, :longitude, :address, :image, :prefectures)
  end

  def ensure_user
    @tweets = current_end_user.tweets
    @tweet = @tweets.find_by(id: params[:id])
    redirect_to  new_tweet_path unless @tweet
  end
end
