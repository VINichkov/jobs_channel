# frozen_string_literal: true

class JobsController < InheritedResources::Base
  load_and_authorize_resource :job, only: %i[edit, update, destroy, approve]
  before_action :set_job, only: %i[edit update destroy]

  def new
    @job = Job.new
  end

  def edit; end

  def update
    respond_to do |format|
      if @job.new?
        if @job.update(job_params)
          format.html { redirect_to job_path, notice: t('edit.job.success') }
        else
          format.html { render :edit }
        end
      else
        format.html { redirect_to job_path, notice: t('edit.job.success') }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: t('destroy.job.success')  }
    end
  end

  def approve
    ApproveJob.call(object: @job, url: job_url)
    respond_to do |format|
      format.html { redirect_to job_path, notice: t('approve.job.success')  }
    end
  end

  def create
    @create_job = CreateJob.call(params: job_params)
    @job = @create_job.object
    respond_to do |format|
      if @create_job.success?
        SendMessage.call(text: job_url(@job), chat: :admin_chat_id)
        format.html { redirect_to @job, notice: t('posted.job.success') }
        format.json { render :show, status: :created, location: @create_job.object }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :company_name, :remote, :location, :salary_min, :salary_max,
                                :contact, :description, :job_type)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
