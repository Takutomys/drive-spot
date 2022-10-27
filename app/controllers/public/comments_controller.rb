class Public::CommentsController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = current_end_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweet_path(tweet)
  end
  
  def destroy
    Comment.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
    redirect_to tweet_path(params[:tweet_id])
  end 
  
  private
  
  def comment_params
     params.require(:comment).permit(:comment)
  end       
  
end
