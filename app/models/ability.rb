class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new

		if user.role? :admin
			# admin can do everything
			can :manage, :all

		elsif user.role? :manager
			# managers can read info on stores, jobs, and flavors
			can :index, Store

		# elsif user.role? :employee
		# 	can

		else 
			can :read, Store
	end

