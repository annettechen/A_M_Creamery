class FlavorsController < ApplicationController
	before_action :set_flavor, only: [:edit, :update, :show, :destroy]
	authorize_resource

	def index
		@active_flavors = Flavor.active.alphabetical.paginate(page: params[:page]).per_page(15)  
		@inactive_flavors = Flavor.inactive.alphabetical.paginate(page: params[:page]).per_page(15)
		@active_stores = Store.active.alphabetical.paginate(page: params[:page]).per_page(5)
	end

	def new
		@flavor = Flavor.new
	end

	def edit
	end

	def create
		@flavor = Flavor.new

		if @flavor.save
			redirect_to flavors_path, notice: "#{@flavor.name} was added to the system."
		else
			render action: 'new'
		end
	end

	def update
		if @flavor.update(flavor_params)
			redirect_to flavors_path, notice: "#{@flavor.name} has been updated."
		else
			render action: 'edit'
		end
	end

	def destroy
		@flavor.destroy
		redirect_to flavors_path, notice: "Successfully removed #{@flavor.name} from the system."
	end

	private

	def set_flavor
		@flavor = Flavor.find(params[:id])
	end

	def flavor_params
		params.require(:flavor).permit(:name)
	end
end