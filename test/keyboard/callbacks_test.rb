require "test_helper"

class CallbacksTest < ActiveSupport::TestCase

  setup do
    @callback_not_like = {:action=>"like", :count=>0, :text=>"👍"}
    @callback_one_like = {:action=>"like", :count=>1, :text=>"👍"}
    @callback_one_like_res = {:action=>"like", :count=>1, :text=>"👍 1"}
    @callback_two_likes = {:action=>"like", :count=>2, :text=>"👍 1"}
    @callback_two_likes_res  = {:action=>"like", :count=>2, :text=>"👍 2"}
    @callback_any = {:action=>"twist", :count=>0, :text=>"!!👍!!"}.to_json
  end

  test 'new like callback' do
    callback = Callbacks::Like.new
    assert_equal @callback_not_like.to_json, callback.to_callback
  end

  test 'parse a like callback not likes' do
    callback = Callbacks::Like.new(@callback_not_like.to_json)
    assert_equal @callback_not_like.to_json, callback.to_callback
  end

  test 'parse a like callback with a like' do
    callback = Callbacks::Like.new(@callback_one_like.to_json)
    assert_equal @callback_one_like_res.to_json, callback.to_callback
  end

  test 'parse a like callback with two likes' do
    callback = Callbacks::Like.new(@callback_two_likes.to_json)
    assert_equal @callback_two_likes_res.to_json, callback.to_callback
  end

  test 'it is my action' do
    assert_equal true, Callbacks::Like.is_my_action?(@callback_not_like.to_json)
  end

  test 'it is not my action' do
    assert_equal false,Callbacks::Like.is_my_action?(@callback_any.to_json)
  end

end