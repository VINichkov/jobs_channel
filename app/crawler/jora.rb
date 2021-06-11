# frozen_string_literal: true

class Jora < Crawler
  SP = 'search'
  ST = 'date'
  def initialize
    super
    @host = 'https://us.jora.com'
    @url = 'https://us.jora.com/j?'
  end

  def get_main_page
    query = {a: '24h', q: @key, l: @location,  sp: SP, st: ST}
    log('Начало')
    request = get_list_jobs(query)
    if request
      rez = request.css('div.result.organic-job, a.result, div.job')
    else
      log("Ответ пустой")
    end
    if rez.present?
      @context = rez.first
    else
      log("По ключам div.result, a.result нет работ")
    end
  end

  def get_list
    title = @context.at_css('a.jobtitle, a.job, a.job-item')
    if title.nil?
      log("Title is null")
      @context = nil
      return nil
    end

    if how_long( @context.at_css('span.date, span.job-listed-date')&.text, title[:title] )
      url = url_to_job( title[:href] )
      company = @context.at_css('div span.company')&.text
      salary = @context.at_css('div div.salary')&.text&.gsub(',', '')&.scan(/\d+/)
      @context = {
          link: url,
          title: title[:title],
          company: company,
          salary_min: salary.present? ? salary[0] : nil,
          salary_max: salary.present? ? salary[1] : nil,
      }

    else
      log("title:#{title[:title]} Работа старая")
      @context = nil
    end
  end

  def url_to_job(url)
    url_from_job = URI(url)
    url_host = URI(@url)
    url_from_job.scheme = url_host.scheme
    url_from_job.host = url_host.host
    url_from_job.to_s
  end

  def get_job
    log( "title: #{@context[:title]} работа ---> url: #{@context[:link]}")
    job = get_page(@context[:link])
    apply_link = job&.css('a.apply_link')&.first
    apply = apply_link ? apply_link[:href] : @context[:link]
    log("title: #{@context[:title]} apply_link #{apply}")
    description = job&.at_css('div#job-description-container')&.children
    if description
    @context = {
        link: @context[:link],
        title: @context[:title],
        company: @context[:company],
        salary_min: @context[:salary_min],
        salary_max: @context[:salary_max],
        location_name: @location,
        description: html_to_markdown(description),
        apply: apply }
    else
      log("title: #{@context[:title]} ERROR description is null #{@context[:link]}")
      @context = nil
    end
  end


end
