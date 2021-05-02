module Callbacks
  class Like
    LIKE = 'like'
    attr_reader :text, :url
    def initialize(text = nil, url:)
      if text.present?
        begin
          @action = params[:action]
          @count = params[:count] + 1
          @text = @count > 0 ? Emoji::LIKE + " #{@count}" : Emoji::LIKE
          @url= params[:url]
        rescue
          Rails.logger.error("Like::Error: initialize text = #{text} : text error #{$!} ")
        end
      else
        @count, @action, @text, @url   = 0, LIKE, Emoji::LIKE, url
      end
    end

    def to_callback
      {action: @action, count: @count, text: @text, url: @url}.to_json
    end

  end

end
