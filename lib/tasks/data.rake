namespace :data do
  desc "Load date"
  task :load => :environment  do
    puts '! Task:load: Start'
    last_id = Job.last&.id
    i = 0
    begin
      Indeed.new.run
      i +=1
    end until Job.last&.id.nil? ? i < 3 : last_id < Job.last&.id
    puts "! Task:load: End"
  end
end