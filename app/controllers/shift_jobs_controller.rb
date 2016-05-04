class ShiftJobsController < ApplicationController
	before_action :set_shift_job, only: [:edit, :show, :update, :destroy]
	authorize_resource

	def index
		@shift_jobs = ShiftJob.all
	end

	def show
	end

	def new
		@shift_job = ShiftJob.new 
	end

	def edit
	end

	def create
		@shift_job = ShiftJob.new(shift_job_params)

		if @shift_job.save
			# redirect_to shift_jobs_path, notice: "#{@job.name} added to list of jobs"
		else
			render action: 'new'
		end
	end

	def update
		if @shift_job.update(shift_job_params)
		    redirect_to shift_jobs_path, notice: "#{@job.name} updated in the system"
		else
			render action: 'edit'
		end
	end

	def destroy
		@shift_job.destroy
		# redirect_to shift_jobs_path, notice: "#{@job.name} successfully removed"
	end

	private

	def set_shift_job
		@shift_job = ShiftJob.find(params[:id])
	end

	def job_params
		params.require(:shift_job).permit(:job_id, :shift_id)
	end
end

	