require "test_helper"

class UserActionTest < ActiveSupport::TestCase

  setup do
    @params_new_user = {
      action: 'like',
      id_message: 2,
      id_user: 2,
      is_bot: true,
      first_name: 'Tom',
      last_name: 'Keller',
      username: 'tom_keller',
      language_code: 'es'
    }
    first = UserAction.first
    @params_familiar = {
      action: 'like',
      id_message: first.id_message,
      id_user: first.id_user,
      is_bot: first.is_bot,
      first_name: first.first_name,
      last_name: first.last_name,
      username: first.username,
      language_code: first.language_code
    }
  end

  test 'new user' do
    reaction = UserAction.click_on_line(@params_new_user)
    assert_equal  :like, reaction
    new_user = JSON.parse( UserAction.last.to_json, opts = { symbolize_names:true } )
    @params_new_user.each do | key, value|
      assert_equal value, new_user[key]
    end
  end

  test 'familiar user' do
    reaction = UserAction.click_on_line(@params_familiar)
    assert_equal  :dislike, reaction
  end

end
