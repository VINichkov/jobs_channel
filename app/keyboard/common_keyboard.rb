class CommonKeyboard

  def self.call(url, title: nil, callback: nil)
    kb = Keyboard.new
    row_one = Row.new
    row_two = Row.new
    callback ||= Callbacks::Like.new
    Rails.logger.info('------ CommonKeyboard ------')
    Rails.logger.info(callback.to_callback)
    Rails.logger.info(to_text)
    Rails.logger.info('------ CommonKeyboard ------')
    row_one.add_button ButtonCallback.new(
      callback.to_text,
      callback.to_callback
    )
    row_one.add_button ButtonUrl.new(
      Emoji::SHARE,
      self.url_for_share(url, title)
    )
    row_two.add_button ButtonUrl.new(
      "View #{Emoji::VIEW}",
      url
    )
    kb.add_rows( [row_one, row_two] )
    kb.to_telegram
  end

  def self.url_for_share(url, title = nil)
    query = {url: url}
    query[:title] = title if title
    "https://t.me/share/url?" + query.to_query
  end

end