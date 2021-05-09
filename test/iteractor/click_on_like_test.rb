require "test_helper"

class ClickOnLikeTest < ActiveSupport::TestCase

  setup do
    @payload = {
      "id"=>"7581854658515103077",
      "from"=>{
        "id"=>1765288100,
        "is_bot"=>false,
        "first_name"=>"John",
        "last_name"=>"Smith",
        "username"=>"John_smith_faker",
        "language_code"=>"ru"},
      "message"=>{
        "message_id"=>66,
        "sender_chat"=>{
          "id"=>-1001463734257,
          "title"=>"Jobs for IT system analyst",
          "username"=>"sys_analyst_usa",
          "type"=>"channel"},
        "chat"=>{"id"=>-1001463734257, "title"=>"Jobs for IT system analyst", "username"=>"sys_analyst_usa", "type"=>"channel"},
        "date"=>1620543720,
        "text"=>"Field 'browser' doesn't contain a valid alias configuration\nCompany: werewr\nLocation: #Sadsad\nRemote: No\nJob type: #FullTime\nJob description\nERROR in ./src/main.js\nModule not found: Error: Can't resolve 'components/DoISuportIt' in '[absolute path to my repo]/src'\nresolve 'components/DoISup...\nContact: kim",
        "entities"=>[
          {"offset"=>0, "length"=>59, "type"=>"bold"},
          {"offset"=>60, "length"=>8, "type"=>"bold"},
          {"offset"=>76, "length"=>9, "type"=>"bold"},
          {"offset"=>86, "length"=>7, "type"=>"hashtag"},
          {"offset"=>94, "length"=>7, "type"=>"bold"},
          {"offset"=>105, "length"=>9, "type"=>"bold"},
          {"offset"=>115, "length"=>9, "type"=>"hashtag"},
          {"offset"=>125, "length"=>15, "type"=>"bold"},
          {"offset"=>258, "length"=>4, "type"=>"bot_command"},
          {"offset"=>294, "length"=>8, "type"=>"bold"}
        ],
        "reply_markup"=>{
          "inline_keyboard"=>
            [
              [
                {"text"=>"👍", "callback_data"=>"{\"action\":\"like\",\"count\":0,\"text\":\"👍\",\"id\":8}"},
                {"text"=>"📣", "url"=>"https://t.me/share/url?url=https%3A%2F%2Fpowerful-caverns-46701.herokuapp.com%2Fjobs%2F8"}
              ],
              [
                {"text"=>"View 👀",
                 "url"=>"https://powerful-caverns-46701.herokuapp.com/jobs/8"}]]}},
      "chat_instance"=>"4418443530368460177",
      "data"=>"{\"action\":\"like\",\"count\":0,\"text\":\"👍\",\"id\":8}"
    }
    @data = @payload["data"]
  end

  test 'click' do
    service_click = ClickOnLike.call(
      callback: Callbacks::Like.new(@data),
      payload: @payload
    )
    puts service_click.reaction
    puts service_click.markup
    puts UserAction.last.to_json
    service_click = ClickOnLike.call(
      callback: Callbacks::Like.new(@data),
      payload: @payload
    )
    puts service_click.reaction
    puts service_click.markup
    puts UserAction.last.to_json
    assert_equal true, false
  end

end