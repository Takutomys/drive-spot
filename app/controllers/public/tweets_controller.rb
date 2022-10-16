class Public::TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    redirect_to tweet_path(@tweet.id)
  end

  def show
  end

  def edit
  end

  def index
  end

  def update
  end

  def destroy
  end

  private

  def tweet_params
     params.require(:tweet).permit(:end_user_id, :name, :introduction, :address, :image, :latitude, :lomgitude)
  end
end
