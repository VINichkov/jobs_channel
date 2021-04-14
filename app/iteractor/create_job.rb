
class CreateJob

  include Interactor

  def call
    context.object = Job.new(context.params)
    unless context.object.save
      context.fail!
    end
  end

end