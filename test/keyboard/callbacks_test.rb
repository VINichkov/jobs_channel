require "test_helper"

class CallbacksTest < ActiveSupport::TestCase

  setup do
    @callback_not_like = {:action=>"like", :count=>0, :text=>"👍"}
    @callback_one_like = {:action=>"like", :count=>1, :text=>"👍 1"}
    @callback_two_likes = {:action=>"like", :count=>2, :text=>"👍 2"}
  end

  test 'parse a like callback not likes' do
    callback = Callbacks::Like.new(@callback_not_like.to_json)
    assert_equal @callback_not_like.to_json, callback.to_callback
  end

  test 'parse a like callback with a like' do
    callback = Callbacks::Like.new(@callback_one_like.to_json)
    assert_equal @callback_one_like.to_json, callback.to_callback
  end

  test 'click like' do
    callback = Callbacks::Like.new(@callback_one_like.to_json)
    callback.like
    assert_equal @callback_two_likes.to_json, callback.to_callback
  end

  test 'click dislike' do
    callback = Callbacks::Like.new(@callback_two_likes.to_json)
    callback.dislike
    assert_equal @callback_one_like.to_json, callback.to_callback
  end

end