namespace :sitemap do
  include Rails.application.routes.url_helpers
  require 'builder'
  desc "Send daily job alert"
  task :create => :environment  do
    puts "! Task:add_jobs: start"
    time = Time.now.strftime("%Y-%m-%d")

    create_file do |i|
      objs = []
      objs << create_item( root_url, time)
      Job.select(:id).order(:id).find_each do |job|
        objs << create_item(job_url(job), time)
      end
      create_xml_sitemap(objs)
    end

    begin
      open("https://google.com/ping?sitemap=#{sitemap_url}.xml")
      open("https://www.bing.com/ping?sitemap=#{sitemap_url}.xml")
    rescue
      puts "____________________Error: #{$!}"
    end

    puts "! Task:add_jobs: End"
  end

  def create_file
    to_file("public/sitemap.xml") { yield }
  end


  def create_xml_sitemap(objs)
    xml = Builder::XmlMarkup.new()
    xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    xml.urlset xmlns:"http://www.sitemaps.org/schemas/sitemap/0.9" do
      objs.each do |obj|
        xml.url do
          xml.loc obj[:url]
          xml.lastmod obj[:date]
          xml.changefreq obj[:changefreq]
        end
      end
    end
    xml.target!
  end

  def to_file(name)
    out_file = File.new(name, "w")
    out_file.puts yield
    out_file.close
  end

  def create_item(url, date, changefreq = 'monthly')
    {url: url, date: date, changefreq: changefreq}
  end

end