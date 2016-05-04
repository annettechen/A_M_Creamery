class HomeController < ApplicationController

  def home
  	if logged_in? 
      @stores = Store.active.alphabetical
  		@employee = current_user.employee
      @current_assignments = Assignment.current.chronological.paginate(page: params[:page]).per_page(5)
  		unless @employee.nil?
	  		@upcoming_shifts = @employee.shifts.upcoming.paginate(page: params[:page]).per_page(5)
	  		unless @upcoming_shifts.empty?
	  			@upcoming_jobs = @upcoming_shifts.first.jobs
	  		end
	  		unless @employee.current_assignment.nil?
	  			@manager_store = @employee.current_assignment.store
	  			@today_shifts = Shift.for_next_days(1).for_store(@manager_store.id).chronological
          @future_shifts = Shift.upcoming.for_store(@manager_store.id).chronological
          @incomplete_shifts = Shift.incomplete.for_store(@manager_store.id).chronological.paginate(page: params[:page]).per_page(5)
        end

	  	end
	  	
  	end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end