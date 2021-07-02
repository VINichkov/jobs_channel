class IndexController < ApplicationController

  def index
    @jobs = Job.where(aasm_state: :approved).order(updated_at: :desc).page( params[:page] )
  end

  def main_search
    @search  = Search.new(search_params)
    if @search.to_query.present?
      @jobs = Job.search(@search).order(updated_at: :desc, rank: :desc).page( params[:page] )
    else
      @jobs = Job.where(aasm_state: :approved).order(updated_at: :desc).page( params[:page] )
    end
  end

  def sitemap
    render file: 'public/sitemap.xml', formats: :xml
  end

  private

  def search_params
    params.require(:search).permit(:search_key, :location, :remote, :job_type, :location, :salary)
  end
end