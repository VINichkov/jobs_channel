class ButtonUrl < Button
  attr_accessor :text, :url
  def initialize( text, url )
    @text, @url = text, url
  end

  def to_h
    { text: @text, url:@url }
  end
end