class ButtonCallback < Button
  attr_accessor :text, :callback
  def initialize( text, callback )
    @text, @callback = text, callback
  end

  def to_h
    { text: @text, callback_data:@callback }
  end
end