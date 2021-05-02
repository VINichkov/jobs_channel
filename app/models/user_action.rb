class UserAction < ApplicationRecord
  attr_accessor :response
  enum action:  { like: 0 }
  def self.click_on_line(args)
    user = UserAction.find_or_create_by(action: args[:action],id_message: args[:id_message],id_user: args[:id_user]) do |row|
      row.action = args[:action]
      row.id_message = args[:id_message]
      row.id_user = args[:id_user]
      row.is_bot = args[:is_bot]
      row.first_name = args[:first_name]
      row.last_name = args[:last_name]
      row.username = args[:username]
      row.language_code = args[:language_code]
      row.value = :dislike
    end
    if user.value == 'like'
      user.update(value: :dislike)
      :dislike
    else
      user.update(value: :like)
      :like
    end
  end
end