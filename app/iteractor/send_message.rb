class SendMessage
  include Interactor
  def call
    Telegram.bot.send_message(
      chat_id: Property.find_prop(context.chat).to_i,
      text: context.text,
      parse_mode: 'HTML'
    )
  end

end