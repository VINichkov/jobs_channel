
class ApproveJob

  include Interactor

  def call
    if context.object.new?
      context.object.approve!
      send = SendMessage.call(
        text: context.object.to_telegram,
        chat: :chat_id,
        keyboard: CommonKeyboard.call(job_id: context.object.id )
      )
      unless send.success?
        context.object.to_new!
      end

    end
  end

end