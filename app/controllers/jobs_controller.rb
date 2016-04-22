class JobsController < ApplicationController
	before_action :set_job, only: [:edit, :new, :update, :destroy]

	def index
	end

	def new
		@job = Job.new
	end

	def edit
	end

	def create
		@job = Job.new(job_params)

		if @job.save
			redirect_to jobs_path, notice: "#{@job.name} added to list of jobs"
		else
			render action: 'new'
		end
	end

	def update
		if @job.update(job_params)
			redirect_to jobs_path, notice: "#{@job.name} updated in the system"
		else
			render action: 'edit'
		end
	end

	def destroy
		@job.destroy
		redirect_to jobs_path, notice: "#{@job.name} successfully removed"
	end

	private

	def set_job
		@job = Job.find(params[:id])
	end

	def job_params
		params.require(:job).permit(:name, :description)
	end
end

	