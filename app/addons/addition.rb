# frozen_string_literal: true

class Addition
  def self.to_hashtag(str)
    "##{str.strip.gsub(/\W/, '_').camelize}" if str.present?
  end
end
