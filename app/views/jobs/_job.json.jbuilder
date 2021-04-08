json.extract! job, :id, :title, :company_name, :string, :company_link, :remote, :type, :location, :salary, :source, :contract, :created_at, :updated_at
json.url job_url(job, format: :json)
