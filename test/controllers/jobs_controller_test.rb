require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:new_job)
  end
=begin
  test "should get index" do
    get jobs_url
    assert_response :success
  end
=end
  test "should get new" do
    get new_job_url
    assert_response :success
  end

=begin
  test "should show job" do
    get job_url(@job)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_url(@job)
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job), params: { job: { company_link: @job.company_link, company_name: @job.company_name, contract: @job.contract, location: @job.location, remote: @job.remote, salary: @job.salary, source: @job.source, string: @job.string, title: @job.title, type: @job.type } }
    assert_redirected_to job_url(@job)
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete job_url(@job)
    end

    assert_redirected_to jobs_url
  end
=end
end
