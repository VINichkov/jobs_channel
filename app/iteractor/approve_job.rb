
class ApproveJob

  include Interactor

  def call
    if context.object.new?
      context.object.approve!
      SendMessage.call(text: context.object.to_telegram[0..100], chat: :chat_id)
      SendMessage.call(text: ' Yes | No', chat: :chat_id)
    end
  end

end