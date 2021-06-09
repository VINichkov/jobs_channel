namespace :data do
  desc "Load date"
  task :load => :environment  do
    puts '! Task:load: Start'
    last_id = Job.last&.id
    begin
      Indeed.new.run
    end until Job.last&.id.nil? ? true : last_id < Job.last&.id
    puts "! Task:load: End"
  end
end