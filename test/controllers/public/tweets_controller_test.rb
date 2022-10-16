require "test_helper"

class Public::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_tweets_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_tweets_edit_url
    assert_response :success
  end

  test "should get index" do
    get public_tweets_index_url
    assert_response :success
  end
end
