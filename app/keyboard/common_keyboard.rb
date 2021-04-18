class CommonKeyboard
  LIKE = "\xF0\x9F\x91\x8D"
  SHARE = "\xF0\x9F\x93\xA3"
  VIEW = "\xF0\x9F\x91\x80"
  def self.call(url)
    return nil if url.nil?
    {inline_keyboard: [
        [
          { text: LIKE, callback_data: 'test1' },
          { text: SHARE, callback_data: "https://t.me/share/url?url={url}&text={text}'test1'"}],
        [{ text: "View #{VIEW}", url: url }]
      ]
    }
  end
end