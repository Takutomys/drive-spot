class Public::FavoritesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_end_user.favorites.new(tweet_id: tweet.id)
    favorite.save
    redirect_to tweet_path(tweet.id)
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_end_user.favorites.find_by(tweet_id: tweet.id)
    favorite.destroy
    redirect_to tweet_path(tweet.id)
  end
end
