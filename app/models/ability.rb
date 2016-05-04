class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new

		if user.role? :admin
			# admin can do everything
			can :manage, :all

		elsif user.role? :manager
			# managers can read info on stores, jobs, and flavors
			can :read, Store

			can :read, Job

			can :read, Flavor

			can :read, Employee do |e|
				current_store = user.employee.current_assignment.store 
				employees_for_store = current_store.employees.map{|e| e.id}
				employees_for_store.include? e.id
			end

			can :read, Assignment do |a|
				current_store = user.employee.current_assignment.store 
				employees_for_store = current_store.employees.map{|e| e.id}
				employees_for_store.include? a.employee.id
			end

			can :read, Shift do |s|
				current_store = user.employee.current_assignment.store 
				employees_for_store = current_store.employees.map{|e| e.id}
				employees_for_store.include? s.employee.id
			end

			can :create, Shift do |s|
				current_store = user.employee.current_assignment.store 
				employees_for_store = current_store.employees.map{|e| e.id}
				(s.store == current_store) && (employees_for_store.include? s.employee.id)
			end

			can :update, Shift do |s|
				current_store = user.employee.current_assignment.store
				s.store == current_store
			end
			can :update, Store do |s|
				current_store = user.employee.current_assignment.store
				s == current_store
			end

			can :destroy, Shift do |s|
				current_store = user.employee.current_assignment.store
				s.store == current_store
			end

			can :create, ShiftJob do |sj|
				current_store = user.employee.current_assignment.store
				sj.shift.store == current_store
			end

			can :destroy, ShiftJob do |sj|
				current_store = user.employee.current_assignment.store
				sj.shift.store == current_store
			end

			can :create, StoreFlavor do |sf|
				current_store = user.employee.current_assignment.store
				sf.shift.store == current_store
			end

			can :destroy, StoreFlavor do |sf|
				current_store = user.employee.current_assignment.store
				sf.shift.store == current_store
			end

		elsif user.role? :employee
			can :read, Store

			can :read, Job

			can :read, Flavor

			can :show, Employee do |e|
				user.employee.id == e.id
			end

			can :show, User do |u|
				u.id == user.id 
			end

			can :show, Assignment do |a|
				a.employee.id == user.employee.id
			end

			can :show, Shift do |s|
				s.employee.id = user.employee.id
			end

			can :start_now, Shift do |s|
				s.employee.id = user.employee.id
			end

			can :end_now, Shift do |s|
				s.employee.id = user.employee.id
			end

			can :show, ShiftJob do |sj|
				sj.shift.employee.id = user.employee.id
			end

			can :update, Employee do |e|
				user.employee.id == e.id
			end

			can :update, User do |u|
				u.id = user.id
			end

		else 
			can :read, Store

			can :read, Flavor
		end

	end
end

