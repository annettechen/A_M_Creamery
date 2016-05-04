class StoreFlavorsController < ApplicationController
	before_action :set_store_flavor, only: [:edit, :show, :update, :destroy]
	authorize_resource

	# def index
	# 	@active_jobs = Job.active.alphabetical.paginate(page: params[:page]).per_page(15)  
	# 	@inactive_jobs = Job.inactive.alphabetical.paginate(page: params[:page]).per_page(15)  
	# end

	def new
		@store_flavor = StoreFlavor.new 
	end

	def edit
	end

	def create
		@store_flavor = StoreFlavor.new(store_flavor_params)

		if @store_flavor.save
			# redirect_to jobs_path, notice: "#{@job.name} added to list of jobs"
		else
			render action: 'new'
		end
	end

	def update
		if @store_flavor.update(store_flavor_params)
			# redirect_to jobs_path, notice: "#{@job.name} updated in the system"
		else
			render action: 'edit'
		end
	end

	def destroy
		@store_flavor.destroy
		# redirect_to jobs_path, notice: "#{@job.name} successfully removed"
	end

	private

	def set_store_flavor
		@store_flavor = StoreFlavor.find(params[:id])
	end

	def job_params
		params.require(:store_flavor).permit(:store_id, :flavor_id)
	end
end

	