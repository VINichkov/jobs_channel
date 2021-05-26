class AutomCreateJob
  include Interactor

  def call
    job = Job.create!(
      title: context.job[:title],
      location: context.job[:location_name],
      salary_min: context.job[:salary_min],
      salary_max: context.job[:salary_max],
      description: context.job[:description],
      company_name: context.job[:company],
      source: context.job[:link],
      #remote: context.job[:remote], #TODO
      #job_type: context.job[:job_type], #TODO
      contact: context.job[:apply]
    )
    ApproveJob.call(object: job)
  end

end