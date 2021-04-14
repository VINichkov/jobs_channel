
class ApproveJob

  include Interactor

  def call
    if context.object.new?
      context.object.approve!
      SendMessage.call(text: context.object.to_telegram, chat: :chat_id)
    end
  end

end