#in future
class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  use_session!

  def start!(*)
    respond_with :message, text: t('.content')
  end

  def help!(*)
    respond_with :message, text: t('.content')
  end

  def write!(text = nil, *)
    session[:text] = text
  end

  def read!(*)
    respond_with :message, text: session[:text]
  end

  def memo!(*args)
    if args.any?
      session[:memo] = args.join(' ')
      respond_with :message, text: t('.notice')
    else
      respond_with :message, text: t('.prompt')
      save_context :memo!
    end
  end

  def remind_me!(*)
    to_remind = session.delete(:memo)
    reply = to_remind || t('.nothing')
    respond_with :message, text: reply
  end

  def keyboard!(value = nil, *)
    if value
      respond_with :message, text: t('.selected', value: value)
    else
      save_context :keyboard!
      respond_with :message, text: t('.prompt'), reply_markup: {
        keyboard: [t('.buttons')],
        resize_keyboard: true,
        one_time_keyboard: true,
        selective: true,
      }
    end
  end

  def callback_query(data)
    begin
      method = JSON.parse(data, opts={symbolize_names:true})
      callback_name = "#{method[:action]}_callback_query".to_sym
      send callback_name, data
    rescue
      Rails.logger.error("Error: #{$!}")
      answer_callback_query 'Error'
    end
  end

  private

  def like_callback_query(data)
    markup = CommonKeyboard.call('https://vk.com', callback: Callbacks::Like.new(data))
    edit_message(:reply_markup, reply_markup: markup)
  end


  def edit_message(type, **params)
    super(type, params)
    answer_callback_query 'Поехали'
  end

 end
