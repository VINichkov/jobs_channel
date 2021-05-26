require 'nokogiri'

class Crawler

  def initialize
    @proxy = Proxy.new
    @location = Property.locations.sample
    @key = Property.find_prop(:key_for_search)
    @context = nil
  end

  def run
    get_main_page
    get_list if @context.present?
    get_job if @context.present?
    create_job if @context.present?
  end


  def get_page(url)
    begin
      Nokogiri::HTML(@proxy.connect(url))
    rescue
      puts ("Ошибка #{$!}")
      nil
    end
  end

  def create_job
    log( "create job #{@context[:link]}")
    AutomCreateJob.call(job: @context)
  end

  def to_file(text, name)
    puts "Не нашли количества страниц всего сохраняем страницу полностью"
      file = File.new(name,"w")
    file.puts text
    file.close
  end

  def how_long(text, title)
    log( "title: #{title} how_long::#{text}" )
    if text == "Just posted" or text=~/hour|1 day|minute|Today/ or text.blank?
      true
    else
      false
    end
  end

  def get_list_jobs( arg )
    url = @url + arg.to_query
    log(  "URL job_list: #{url}" )
    get_page(url)
  end

  def update_attr(attr)
    attr.css('*').each do |elem|
      if elem&.count>0 then
        elem.each do |attr, value|
          elem.remove_attribute(attr)
        end
      end
    end
    attr.to_s
  end


  def gsub_html(arg)
    arg.gsub(/<span>|<\/span>|<div>|<\/div>/,"")
       .gsub(/<h1>|<h2>|<h3>/,"<h4>")
       .gsub(/<\/h1>|<\/h2>|<\/h3>/,"</h4>").squish.gsub("> <","><")
  end

  def html_to_markdown(arg)
    gsub_html(update_attr(arg))
  end

  def log( message = nil)
    puts "#{Time.now} | location = #{@location},  message = #{message}"
  end

end