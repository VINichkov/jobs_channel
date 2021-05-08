class Row
  attr_accessor :row
  def initialize(row = [])
    @row = row
  end

  def add_buttons( btns )
    @row += btns
  end

  def add_button( btn )
    @row.push btn
  end

  def to_telegram
    @row.map{|btn| btn.to_h}
  end

end