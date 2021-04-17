class SendMessage
  include Interactor
  def call
    begin
      Telegram.bot.send_message(
        chat_id: Property.find_prop(context.chat).to_i,
        text: context.text,
        parse_mode: 'HTML'
      )
    rescue
      Telegram.bot.send_message(
        chat_id: Property.find_prop(:admin_chat_id).to_i,
        text: "Error: #{$!}"
      )
      context.fail!
    end




  end

end