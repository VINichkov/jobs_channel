
class ApproveJob

  include Interactor

  def call
    if context.object.new?
      context.object.approve!
      send = SendMessage.call(text: context.object.to_telegram[0..100], chat: :chat_id)
      if send.success?
        SendMessage.call(text: '<button> </botton>', chat: :chat_id)
        SendMessage.call(text: '<button> </botton>', chat: :chat_id)
      else
        context.object.to_new!
      end
    end
  end

end