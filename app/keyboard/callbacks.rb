module Callbacks
  class Like
    LIKE = 'like'
    def initialize(text = nil)
      if text.present?
        begin
          params = JSON.parse(text, opts={symbolize_names:true})
          @action = params[:action]
          @count = params[:count]
          @text = @count > 0 ? Emoji::LIKE + " #{@count}" : Emoji::LIKE
        rescue
          Rails.logger.error("Like::Error: initialize text = #{text} : text error #{$!} ")
        end
      else
        @count = 0
        @action = LIKE
        @text = Emoji::LIKE
      end
    end

    def to_callback
      {action: @action, count: @count, text: @text}.to_json
    end

    def to_text
      @text
    end

    def self.is_my_action?(data)
      params = JSON.parse(data, opts={symbolize_names:true})
      params.is_a?(Hash) && params[:action] == LIKE
    end

  end


end
