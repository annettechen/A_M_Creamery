class ShiftsController < ApplicationController
	before_action :set_shift, only: [:edit, :update, :show, :destroy, :start_now, :end_now]
	authorize_resource

	def index
		if logged_in?
			if current_user.role?(:employee)
				@shifts = Shift.for_employee(current_user.employee).chronological.paginate(page: params[:page]).per_page(15)  
				@upcoming_shifts = Shift.for_employee(current_user.employee).chronological.upcoming.paginate(page: params[:page]).per_page(15)  
			elsif current_user.role?(:manager)
				@shifts = Shift.for_store(current_user.employee.current_assignment.store).chronological.paginate(page: params[:page]).per_page(15) 
				@upcoming_shifts = Shift.for_store(current_user.employee.current_assignment.store).chronological.upcoming.paginate(page: params[:page]).per_page(15) 
			else
				@shifts = Shift.chronological.paginate(page: params[:page]).per_page(15)  
				@upcoming_shifts = Shift.chronological.upcoming.paginate(page: params[:page]).per_page(15)  
			end
		end
	end

	def new
		@shift = Shift.new
	end

	def edit
	end

	def show
		@jobs = @shift.jobs.paginate(page: params[:page]).per_page(5)
	end

	def create
		@shift = Shift.new(shift_params)

		if @shift.save
			redirect_to shifts_path, notice: "Shift for #{@shift.employee.name} added to the system"
		else
			render action: 'new'
		end
	end

	def update
		if @shift.update(shift_params)
			redirect_to shifts_path, notice: "Shift for #{@shift.employee.name} has been updated"
		else
			render action: 'edit'
		end
	end

	def destroy
		@shift.destroy
		redirect_to shifts_path, notice: "Shift for #{@shift.employee.name} has been successfully destroyed"
	end

	def start_now
		@shift.start_now
		@shift.save
		respond_to do |format| 
			format.js

		end
	end

	def end_now
		@shift.end_now
		@shift.save
		respond_to do |format| 
			format.js
		end
	end

	private

	def set_shift
		@shift = Shift.find(params[:id])
	end

	def shift_params
		params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :job_ids => [])
	end
end
