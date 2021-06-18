namespace :data do
  desc "Load date"
  task :load => :environment  do
    puts '! Task:load: Start v1'
    rand = [true, false, false, false, false, false, false, false, false, false]
    if rand.sample
      start_load
    end

    puts "! Task:load: End"
  end

  desc "Load date"
  task :load_now => :environment  do
    puts '! Task:load: Start v2'
    start_load

    puts "! Task:load: End"
  end


  def start_load
    puts "loading..."
    last_id = Job.last&.id
    i = 0
    begin
      Jora.new.run
      i += 1
    end until Job.last&.id.nil? ? i < 3 : last_id < Job.last&.id
  end
end