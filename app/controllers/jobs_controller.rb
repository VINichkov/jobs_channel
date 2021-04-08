# frozen_string_literal: true

class JobsController < InheritedResources::Base


  def new
    @job = Job.new
  end


  def create
    @job = Job.new(job_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: t('posted.job.success') }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :company_name, :string, :company_link, :remote, :type, :location, :salary,
                                :source, :contract)
  end
end

