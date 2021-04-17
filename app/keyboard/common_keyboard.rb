class CommonKeyboard
  def self.call(url)
    return nil if url.nil?
    {inline_keyboard: [
        [{ text: 'Like', callback_data: 'test1' }],
        [{ text: 'share', callback_data: 'test1' }],
        [{ text: 'share', url: url }]
      ]
    }
  end
end