module Callbacks
  class Like
    LIKE = 'like'
    attr_reader :text, :id
    def initialize(text = nil, id: nil)
      if text.present?
        begin
          params = JSON.parse(text, opts={symbolize_names:true})
          @action = params[:action]
          @count = params[:count]
          @text = params[:text]
          @id = params[:id]
        rescue
          Rails.logger.error("Like::Error: initialize text = #{text} : text error #{$!} ")
        end
      else
        @count, @action, @text, @id  = 0, LIKE, Emoji::LIKE, id
      end
    end

    def like
      @count +=1
      update_text
    end

    def dislike
      @count -=1
      update_text
    end

    def to_callback
      {action: @action,
       count: @count,
       text: @text,
       id: @id
      }.to_json
    end

    private

    def update_text
      @text = @count > 0 ? Emoji::LIKE + " #{@count}" : Emoji::LIKE
    end

  end

end
