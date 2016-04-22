class ShiftsController < ApplicationController
	before_action :set_shift, only: [:edit, :update, :show, :destroy]

	def index
		@shifts = Shift.chronological.paginate(page: params[:page]).per_page(15)  
	end

	def new
		@shift = Shift.new
	end

	def edit
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

	private

	def set_shift
		@shift = Shift.find(params[:id])
	end

	def shift_params
		params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes)
	end
end
