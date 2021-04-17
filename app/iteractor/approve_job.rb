
class ApproveJob

  include Interactor

  def call
    if context.object.new?
      context.object.approve!
      send = SendMessage.call(
        text: context.object.to_telegram[0..100],
        chat: :chat_id,
        keyboard: CommonKeyboard.call( context.url )
      )
      unless send.success?
        context.object.to_new!
      end

    end
  end

end