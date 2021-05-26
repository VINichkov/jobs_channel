class SendMessage
  include Interactor
  def call
    Rails.logger.debug(context.keyboard)
    begin
      Telegram.bot.send_message(
        create_params(
          context.text,
          context.chat,
          'HTML',
          context.keyboard
        )
      )
    rescue StandardError
      Rails.logger.error("Error SendMessage: #{$!}")
      Telegram.bot.send_message( create_params("Error: #{$!}") )
      context.fail!
    end
  end

  private
  def create_params(text, chat = :admin_chat_id, parse_mode = nil, reply_markup = nil)
    result = { text: text, chat_id: Property.find_prop(chat).to_i }
    result[:parse_mode] = parse_mode if parse_mode
    result[:reply_markup] = reply_markup if reply_markup
    result
  end

end
