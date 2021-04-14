# frozen_string_literal: true

module Lib
  def to_hashtag(str)
    "##{str.strip.gsub(/\W/, '_').camelize}" if str.present?
  end
end
