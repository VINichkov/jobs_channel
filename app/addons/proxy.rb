require 'net/http'

class Proxy
  def initialize(proxy: Property.find_prop(:proxy))
    @proxy = proxy
  end

  def connect(arg = 'https://rbc.ru')
    pattern arg: arg, url: 'open'
  end

  def redirect(arg)
    if arg
      pattern arg: arg, url: 'redirect'
    end
  end

  private

  def pattern(arg:, url:)
    arg= {url: arg}
    flag = true
    respond = nil
    i = 0
    while flag and i<3 do
      begin
        i +=1
        uri = URI("#{@proxy}/#{url}?" + arg.to_query)
        respond = Net::HTTP.get(uri).force_encoding('UTF-8')
        flag = false
      rescue
        Rails.logger.error("Ошибка #{$!}")
        flag = true
      end
    end
    respond
  end

end