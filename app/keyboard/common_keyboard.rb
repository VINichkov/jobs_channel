class CommonKeyboard

  def self.call(url, title = nil)
    kb = Keyboard.new
    row_one = Row.new
    row_two = Row.new
    row_one.add_button ButtonCallback.new(
      Emoji::LIKE,
      Callbacks::LIKE
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