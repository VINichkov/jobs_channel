class ButtonUrl < Button
  attr_accessor :text, :url
  def initialize( text, url )
    #Telegram want only https but developer mode has http
    url = 'https://vk.com' if !Rails.env.production? and  url[0..4] == 'http:'
    @text, @url = text, url
  end

  def to_h
    { text: @text, url:@url }
  end
end