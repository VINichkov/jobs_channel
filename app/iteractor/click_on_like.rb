class ClickOnLike
  include Interactor
  def call
    context.reaction = UserAction.click_on_line(params)
    context.callback.send context.reaction
    context.markup = CommonKeyboard.call( callback: context.callback)
  end

  private
  def params
    params = context.payload["from"].to_hash.symbolize_keys!
    params[:action] = :like
    params[:id_user] = params[:id]
    params[:id_message] = context.payload["message"]["message_id"]
    params
  end
end