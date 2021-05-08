class Keyboard
  attr_accessor :inline_keyboard

  def initialize(inline_keyboard = [])
    @inline_keyboard = inline_keyboard
  end

  def add_rows( rows )
    @inline_keyboard += rows
  end

  def add_row( row )
    @inline_keyboard += row
  end

  def to_telegram
    inline_keyboard = @inline_keyboard.map{ |row| row.to_telegram}
    {inline_keyboard: inline_keyboard}
  end

end