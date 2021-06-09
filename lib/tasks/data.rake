namespace :data do
  desc "Load date"
  task :load => :environment  do
    puts '! Task:load: Start'
    last_id = Job.last&.id
    begin
      Indeed.new.run
    end until last_id < Job.last&.id or Job.last&.id.nil?
    puts "! Task:load: End"
  end
end