class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	# authorize_resource

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	    if @user.save
	      session[:user_id] = @user.id
	      redirect_to home_path, notice: "Thank you for signing up!"
	    else
	      flash[:error] = "This user could not be created."
	      render "new"
	    end
	end

	def update
		 if @user.update_attributes(user_params)
	      flash[:notice] = "The user has been updated."
	      redirect_to @user
	    else
	      render :action => 'edit'
	    end
	end

	def edit
	end

	def destroy
		@user.destroy
	    flash[:notice] = "Successfully removed the user."
	    redirect_to home_path
	end 

	private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
